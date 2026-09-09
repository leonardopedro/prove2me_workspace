import Mathlib
import BookProof.ChapterFockSecondQuantization
import BookProof.ChapterNavierStokesFockEsa
import BookProof.ChapterStoneBridge

/-!
# The graded (bosonic ⊗ fermionic) Fock space of quantum gravity — Part E

`PLAN_LEAN_SPECIALIST_QG_FLOW.md` Part E (`CONSOLIDATED_PLAN.md` §10.6.2 item 3) asks for
the second quantization of the gauge-fixed gravity Hamiltonian on the book's graded Fock
space

`Γˢ(L²(ℝ⁸⁴ × ℤ₂¹⁹)) ⊗ Γᵃ(L²(ℝ⁸⁴ × ℤ₂¹⁹))`,

the tensor product of a symmetric (bosonic) and an antisymmetric (fermionic, ghost) Fock
space, together with the `ℤ₂`-graded superalgebra of its creation and annihilation
operators.  The bosonic half is a direct reuse of
`BookProof/ChapterFockSecondQuantization.lean` (the Yang–Mills Part F.11 module); the new
content of this module is the **fermionic (CAR) half and the `ℤ₂` grading**.

## What is proved here

* **The fermionic configurations and the Jordan–Wigner sign.**  A fermionic configuration
  is a finite set of occupied modes (`FermConf = Finset ℕ`; the Pauli principle is built
  into the *set*, not imposed), and `jwSign j α = (−1)^{#\{i ∈ α : i < j\}}` is the sign
  that orders the mode `j` against the already occupied lower modes.
* **The ladder operators** `fermAnn j`, `fermCre j` on the algebraic fermionic Fock space
  `FermAlg = FermConf →₀ ℂ`, with their coordinate formulas `fermAnn_apply`,
  `fermCre_apply`, and the **canonical anticommutation relations** (E.3)
  * `car_fermAnn_fermCre` — `{ψ_j, ψ_j†} = 1`;
  * `car_fermAnn_fermCre_of_ne` — `{ψ_j, ψ_k†} = 0` for `j ≠ k`;
  * `car_fermAnn_fermAnn`, `car_fermCre_fermCre` — `{ψ_j, ψ_k} = {ψ_j†, ψ_k†} = 0`;
  * `fermAnn_comp_self`, `fermCre_comp_self` — hence `ψ_j² = (ψ_j†)² = 0`, the Pauli
    exclusion principle in operator form.
  `inner_fermCre_left` checks on the Hilbert space `ℓ²(FermConf)` that `ψ_j†` really is the
  adjoint of `ψ_j`, so the CAR are relations between an operator and its adjoint.
* **The `ℤ₂` grading** (E.4).  `fermGrade` is the parity operator `Γ = (−1)^F`, with
  `fermGrade_involutive`; the ladder operators are **odd** (`fermGrade_fermAnn`,
  `fermGrade_fermCre`), and `superBracket` is the graded bracket
  `[x, y} = xy − (−1)^{|x||y|} yx`, for which `superBracket_fermAnn_fermCre` restates the
  CAR and `superBracket_bosOp_ghostOp` says bosonic and ghost operators supercommute.
* **The graded state space** `QGGraded = FockAlg ⊗ FermAlg` with `bosOp` and `ghostOp`, the
  commutation `bosOp_ghostOp_comm`, the canonical relations `qgCCR` (bosonic) and
  `qgGhostCar` (fermionic) transported to it, and `qgGrade`, the total parity, for which
  `bosOp_even` and `ghostOp_odd` fix the degrees.
* **The graded Fock space and its Hamiltonian** (E.5, E.5b, E.6).  `GradedIdx =
  Conf × FermConf` indexes the joint occupation states; `qgGradedSymbol ω g` is the total
  energy `∑ₖ nₖ ωₖ + ∑_{a ∈ α} gₐ` of a boson configuration together with a ghost
  configuration, `qgGradedHam` the corresponding operator on the finite-occupation domain,
  and
  * **`qgGradedFock_esa`** — it is essentially self-adjoint there, with **no** boundedness
    or positivity assumption on either the boson or the ghost energies (the QG operator is
    indefinite, so this matters), and
  * **`qgGradedFock_stone_flow`** — hence it generates the unitary group `e^{−itH}` on the
    graded Fock space.
  `qgGradedFock_not_bounded` records that this is not a boundedness phenomenon.
  `qgDGamma_esa` and `qgTwoLevel_esa` register the general (bosonic) second-quantization
  and Fock-of-Fock theorems the plan asks to reuse, and `qgFock_hashimoto_selects`
  instantiates the shift-invert selection theorem on the Gauss–polynomial core of
  `L²(ℝ⁸⁴)`.

## Honest boundary

The Hamiltonian second-quantized here is the **particle-number preserving** one: a real
one-particle symbol for the bosons and a real ghost energy, with no sector-changing
interaction and no BRST charge (that is `ChapterQuantumGravityBrstCharge`, whose ghost CAR
on `Λ(ℂ¹⁹)` is the finite-mode counterpart of the fermionic half built here).  The
continuum one-particle essential self-adjointness of the full gauge-fixed operator on
`L²(ℝ⁸⁴ × ℤ₂¹⁹)` is *not* claimed; it is the hypothesis that the Fock-level theorems
consume.  No mass gap and no global existence is claimed.
-/

namespace BookProof.QuantumGravityFock

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

/-! ## E.1/E.2 — the bosonic half (reuse)

The bosonic configurations, the algebraic Fock space and the ladder operators are those of
`BookProof.FockSecondQuantization`; only their gravity-facing names are new. -/

/-- The bosonic (one-particle mode) configurations of the gravity Fock space. -/
abbrev BoseConf := BookProof.FockSecondQuantization.Conf

/-- The algebraic bosonic Fock space. -/
abbrev BoseAlg := BookProof.FockSecondQuantization.FockAlg

/-- **E.2 — the bosonic canonical commutation relation** `[a_j, a_j†] = 1`. -/
theorem qgCCR_bose (j : ℕ) (u : BoseAlg) : annA j (creA j u) - creA j (annA j u) = u :=
  ccr_annA_creA j u

/-- The off-diagonal bosonic commutation relation `[a_j, a_k†] = 0`, `j ≠ k`. -/
theorem qgCCR_bose_of_ne {j k : ℕ} (h : j ≠ k) (u : BoseAlg) :
    annA j (creA k u) - creA k (annA j u) = 0 := by
  rw [ccr_annA_creA_of_ne h u, sub_self]

/-! ## E.3 — the fermionic (ghost) half: configurations and the Jordan–Wigner sign -/

/-- A **fermionic configuration**: the finite set of occupied ghost modes.  The Pauli
principle is built into the representation — a mode is occupied or not. -/
abbrev FermConf := Finset ℕ

/-- The **algebraic fermionic Fock space**: finite linear combinations of fermionic
configurations. -/
abbrev FermAlg := FermConf →₀ ℂ

/-- The number of occupied modes below `j`: the Jordan–Wigner string length. -/
def jwCount (j : ℕ) (α : FermConf) : ℕ := (α.filter (fun i => i < j)).card

/-- The **Jordan–Wigner sign** `(−1)^{#\{i ∈ α : i < j\}}` picked up when the mode `j` is
moved past the occupied modes below it. -/
def jwSign (j : ℕ) (α : FermConf) : ℂ := (-1) ^ jwCount j α

theorem jwCount_insert_of_lt {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∉ α) :
    jwCount j (insert i α) = jwCount j α + 1 := by
  classical
  rw [jwCount, jwCount, Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem]
  exact fun hc => hi (Finset.mem_of_mem_filter _ hc)

theorem jwCount_insert_of_le {i j : ℕ} {α : FermConf} (h : j ≤ i) :
    jwCount j (insert i α) = jwCount j α := by
  classical
  rw [jwCount, jwCount, Finset.filter_insert, if_neg (by omega)]

theorem jwCount_erase_of_lt {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∈ α) :
    jwCount j α = jwCount j (α.erase i) + 1 := by
  classical
  have hfilter : (α.erase i).filter (fun x => x < j) = (α.filter (fun x => x < j)).erase i := by
    rw [Finset.filter_erase]
  rw [jwCount, jwCount, hfilter, Finset.card_erase_of_mem (Finset.mem_filter.mpr ⟨hi, h⟩)]
  have : 1 ≤ (α.filter (fun x => x < j)).card :=
    Finset.card_pos.mpr ⟨i, Finset.mem_filter.mpr ⟨hi, h⟩⟩
  omega

theorem jwCount_erase_of_le {i j : ℕ} {α : FermConf} (h : j ≤ i) :
    jwCount j (α.erase i) = jwCount j α := by
  classical
  have hfilter : (α.erase i).filter (fun x => x < j) = (α.filter (fun x => x < j)).erase i := by
    rw [Finset.filter_erase]
  rw [jwCount, jwCount, hfilter, Finset.erase_eq_of_notMem]
  intro hc
  have := (Finset.mem_filter.mp hc).2
  omega

@[simp] theorem jwSign_insert_self (j : ℕ) (β : FermConf) : jwSign j (insert j β) = jwSign j β := by
  simp [jwSign, jwCount, Finset.filter_insert]

@[simp] theorem jwSign_erase_self (j : ℕ) (β : FermConf) : jwSign j (β.erase j) = jwSign j β := by
  simp [jwSign, jwCount, Finset.filter_erase]

/-- The Jordan–Wigner sign is a sign: it squares to one. -/
theorem jwSign_mul_self (j : ℕ) (α : FermConf) : jwSign j α * jwSign j α = 1 := by
  rw [jwSign, ← pow_add]
  rcases Nat.even_or_odd (jwCount j α) with he | ho
  · rw [Even.neg_one_pow (he.add he)]
  · rw [Even.neg_one_pow (ho.add_odd ho)]

theorem conj_jwSign (j : ℕ) (α : FermConf) : (starRingEnd ℂ) (jwSign j α) = jwSign j α := by
  rw [jwSign, map_pow, map_neg, map_one]

theorem jwSign_insert_of_lt {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∉ α) :
    jwSign j (insert i α) = - jwSign j α := by
  rw [jwSign, jwSign, jwCount_insert_of_lt h hi, pow_succ]; ring

theorem jwSign_insert_of_le {i j : ℕ} {α : FermConf} (h : j ≤ i) :
    jwSign j (insert i α) = jwSign j α := by
  rw [jwSign, jwSign, jwCount_insert_of_le h]

theorem jwSign_erase_of_lt {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∈ α) :
    jwSign j (α.erase i) = - jwSign j α := by
  rw [jwSign, jwSign, jwCount_erase_of_lt h hi, pow_succ]; ring

theorem jwSign_erase_of_le {i j : ℕ} {α : FermConf} (h : j ≤ i) :
    jwSign j (α.erase i) = jwSign j α := by
  rw [jwSign, jwSign, jwCount_erase_of_le h]

/-- Exchanging two creations flips the Jordan–Wigner sign. -/
theorem jw_swap_insert {j k : ℕ} (h : j ≠ k) {α : FermConf} (hj : j ∉ α) (hk : k ∉ α) :
    jwSign j α * jwSign k (insert j α) = - (jwSign k α * jwSign j (insert k α)) := by
  rcases lt_or_gt_of_ne h with hlt | hgt
  · rw [jwSign_insert_of_lt hlt hj, jwSign_insert_of_le (le_of_lt hlt)]; ring
  · rw [jwSign_insert_of_le (le_of_lt hgt), jwSign_insert_of_lt hgt hk]; ring

/-- Exchanging two annihilations flips the Jordan–Wigner sign. -/
theorem jw_swap_erase {j k : ℕ} (h : j ≠ k) {α : FermConf} (hj : j ∈ α) (hk : k ∈ α) :
    jwSign j α * jwSign k (α.erase j) = - (jwSign k α * jwSign j (α.erase k)) := by
  rcases lt_or_gt_of_ne h with hlt | hgt
  · rw [jwSign_erase_of_lt hlt hj, jwSign_erase_of_le (le_of_lt hlt)]; ring
  · rw [jwSign_erase_of_le (le_of_lt hgt), jwSign_erase_of_lt hgt hk]; ring

/-- Exchanging a creation with an annihilation of a different mode flips the sign. -/
theorem jw_swap_mixed {j k : ℕ} (h : j ≠ k) {α : FermConf} (hj : j ∉ α) (hk : k ∈ α) :
    jwSign j α * jwSign k (insert j α) = - (jwSign k α * jwSign j (α.erase k)) := by
  rcases lt_or_gt_of_ne h with hlt | hgt
  · rw [jwSign_insert_of_lt hlt hj, jwSign_erase_of_le (le_of_lt hlt)]; ring
  · rw [jwSign_insert_of_le (le_of_lt hgt), jwSign_erase_of_lt hgt hk]; ring

/-! ## E.3 — the fermionic ladder operators and the CAR -/

/-- **The fermionic annihilation operator** of the mode `j`: on a configuration state,
`ψ_j |α⟩ = 0` if the mode is empty, and `(−1)^{jw} |α ∖ \{j\}⟩` if it is occupied. -/
def fermAnn (j : ℕ) : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (if j ∈ β then Finsupp.single (β.erase j) (jwSign j β) else 0)

/-- **The fermionic creation operator** of the mode `j`: on a configuration state,
`ψ_j† |α⟩ = 0` if the mode is already occupied (Pauli), and `(−1)^{jw} |α ∪ \{j\}⟩` if it
is empty. -/
def fermCre (j : ℕ) : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (if j ∈ β then 0 else Finsupp.single (insert j β) (jwSign j β))

@[simp] theorem fermAnn_single (j : ℕ) (β : FermConf) (c : ℂ) :
    fermAnn j (Finsupp.single β c)
      = c • (if j ∈ β then Finsupp.single (β.erase j) (jwSign j β) else 0) := by
  simp [fermAnn, LinearMap.toSpanSingleton]

@[simp] theorem fermCre_single (j : ℕ) (β : FermConf) (c : ℂ) :
    fermCre j (Finsupp.single β c)
      = c • (if j ∈ β then 0 else Finsupp.single (insert j β) (jwSign j β)) := by
  simp [fermCre, LinearMap.toSpanSingleton]

/-- The coordinates of `ψ_j u`. -/
theorem fermAnn_apply (j : ℕ) (u : FermAlg) (α : FermConf) :
    fermAnn j u α = if j ∈ α then 0 else jwSign j α * u (insert j α) := by
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
      simp only [map_add, Finsupp.add_apply, hf, hg]
      split <;> ring
  | single β c =>
    rw [fermAnn_single]
    by_cases hja : j ∈ α
    · simp only [hja, if_true]
      by_cases hjb : j ∈ β
      · have hne : β.erase j ≠ α := by
          intro h; rw [← h] at hja; exact (Finset.notMem_erase j β) hja
        simp [hjb, Ne.symm hne]
      · simp [hjb]
    · simp only [hja, if_false]
      by_cases hb : β = insert j α
      · subst hb
        have hjb : j ∈ insert j α := Finset.mem_insert_self j α
        simp only [hjb, if_true, Finset.erase_insert hja, Finsupp.smul_apply,
          Finsupp.single_eq_same, smul_eq_mul, jwSign_insert_self]
        ring
      · have h1 : (Finsupp.single β c : FermAlg) (insert j α) = 0 := by
          simp [Ne.symm hb]
        rw [h1, mul_zero]
        by_cases hjb : j ∈ β
        · have hne : β.erase j ≠ α := by
            intro h
            exact hb (by rw [← h, Finset.insert_erase hjb])
          simp [hjb, hne]
        · simp [hjb]

/-- The coordinates of `ψ_j† u`. -/
theorem fermCre_apply (j : ℕ) (u : FermAlg) (α : FermConf) :
    fermCre j u α = if j ∈ α then jwSign j α * u (α.erase j) else 0 := by
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
      simp only [map_add, Finsupp.add_apply, hf, hg]
      split <;> ring
  | single β c =>
    rw [fermCre_single]
    by_cases hja : j ∈ α
    · simp only [hja, if_true]
      by_cases hb : β = α.erase j
      · subst hb
        have hjb : j ∉ α.erase j := Finset.notMem_erase j α
        simp only [hjb, if_false, Finset.insert_erase hja, Finsupp.smul_apply,
          Finsupp.single_eq_same, smul_eq_mul, jwSign_erase_self]
        ring
      · have h1 : (Finsupp.single β c : FermAlg) (α.erase j) = 0 := by
          simp [Ne.symm hb]
        rw [h1, mul_zero]
        by_cases hjb : j ∈ β
        · simp [hjb]
        · have hne : insert j β ≠ α := by
            intro h
            exact hb (by rw [← h, Finset.erase_insert hjb])
          simp [hjb, hne]
    · simp only [hja, if_false]
      by_cases hjb : j ∈ β
      · simp [hjb]
      · have hne : insert j β ≠ α := by
          intro h; rw [← h] at hja; exact hja (Finset.mem_insert_self j β)
        simp [hjb, hne]

/-- **The canonical anticommutation relation** `{ψ_j, ψ_j†} = 1`. -/
theorem car_fermAnn_fermCre (j : ℕ) (u : FermAlg) :
    fermAnn j (fermCre j u) + fermCre j (fermAnn j u) = u := by
  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, fermAnn_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · simp only [if_pos hj, zero_add, if_neg (Finset.notMem_erase j α), jwSign_erase_self,
      Finset.insert_erase hj, ← mul_assoc, jwSign_mul_self, one_mul]
  · simp only [if_neg hj, add_zero, if_pos (Finset.mem_insert_self j α), jwSign_insert_self,
      Finset.erase_insert hj, ← mul_assoc, jwSign_mul_self, one_mul]

/-- **The canonical anticommutation relation** `{ψ_j, ψ_k} = 0` (in particular
`ψ_j² = 0`). -/
theorem car_fermAnn_fermAnn (j k : ℕ) (u : FermAlg) :
    fermAnn j (fermAnn k u) + fermAnn k (fermAnn j u) = 0 := by
  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermAnn_apply]
  rcases eq_or_ne j k with rfl | h
  · by_cases hj : j ∈ α
    · simp [hj]
    · rw [if_neg hj, if_pos (Finset.mem_insert_self j α)]
      ring
  · by_cases hj : j ∈ α
    · rw [if_pos hj, if_pos (Finset.mem_insert_of_mem hj)]
      split <;> ring
    · by_cases hk : k ∈ α
      · rw [if_neg hj, if_pos hk, if_pos (Finset.mem_insert_of_mem hk)]
        ring
      · rw [if_neg hj, if_neg hk, if_neg (by simp [hk, Ne.symm h]), if_neg (by simp [hj, h]),
          Finset.insert_comm k j α, ← mul_assoc, ← mul_assoc, jw_swap_insert h hj hk]
        ring

/-- **The canonical anticommutation relation** `{ψ_j†, ψ_k†} = 0` (in particular
`(ψ_j†)² = 0`, the Pauli exclusion principle). -/
theorem car_fermCre_fermCre (j k : ℕ) (u : FermAlg) :
    fermCre j (fermCre k u) + fermCre k (fermCre j u) = 0 := by
  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermCre_apply]
  rcases eq_or_ne j k with rfl | h
  · by_cases hj : j ∈ α
    · rw [if_pos hj, if_neg (Finset.notMem_erase j α)]
      ring
    · simp [hj]
  · by_cases hj : j ∈ α
    · by_cases hk : k ∈ α
      · rw [if_pos hj, if_pos hk, if_pos (by simp [hk, Ne.symm h] : k ∈ α.erase j),
          if_pos (by simp [hj, h] : j ∈ α.erase k), Finset.erase_right_comm (a := j) (b := k),
          ← mul_assoc, ← mul_assoc, jw_swap_erase h hj hk]
        ring
      · rw [if_pos hj, if_neg hk, if_neg (by simp [hk] : k ∉ α.erase j)]
        ring
    · by_cases hk : k ∈ α
      · rw [if_neg hj, if_pos hk, if_neg (by simp [hj] : j ∉ α.erase k)]
        ring
      · rw [if_neg hj, if_neg hk]
        ring

/-- **The off-diagonal canonical anticommutation relation** `{ψ_j, ψ_k†} = 0`,
`j ≠ k`. -/
theorem car_fermAnn_fermCre_of_ne {j k : ℕ} (h : j ≠ k) (u : FermAlg) :
    fermAnn j (fermCre k u) + fermCre k (fermAnn j u) = 0 := by
  refine Finsupp.ext fun α => ?_
  simp only [Finsupp.add_apply, Finsupp.zero_apply, fermAnn_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · rw [if_pos hj, zero_add]
    by_cases hk : k ∈ α
    · rw [if_pos hk, if_pos (by simp [hj, h] : j ∈ α.erase k)]
      ring
    · rw [if_neg hk]
  · rw [if_neg hj]
    by_cases hk : k ∈ α
    · rw [if_pos hk, if_pos (by simp [hk] : k ∈ insert j α),
        if_neg (by simp [hj] : j ∉ α.erase k), Finset.erase_insert_of_ne h,
        ← mul_assoc, ← mul_assoc, jw_swap_mixed h hj hk]
      ring
    · rw [if_neg hk, if_neg (by simp [hk, Ne.symm h] : k ∉ insert j α)]
      ring

/-- `ψ_j² = 0`. -/
theorem fermAnn_comp_self (j : ℕ) (u : FermAlg) : fermAnn j (fermAnn j u) = 0 := by
  have h := car_fermAnn_fermAnn j j u
  have : (2 : ℂ) • fermAnn j (fermAnn j u) = 0 := by
    rw [two_smul]; exact h
  simpa using this

/-- `(ψ_j†)² = 0` — the Pauli exclusion principle in operator form. -/
theorem fermCre_comp_self (j : ℕ) (u : FermAlg) : fermCre j (fermCre j u) = 0 := by
  have h := car_fermCre_fermCre j j u
  have : (2 : ℂ) • fermCre j (fermCre j u) = 0 := by
    rw [two_smul]; exact h
  simpa using this

/-! ## The fermionic Fock space `ℓ²(FermConf)` and the adjoint pairing -/

/-- The fermionic Fock space `ℓ²` over the fermionic configurations. -/
abbrev FermFock := lp (fun _ : FermConf => ℂ) 2

/-- A finitely supported fermionic state as an element of `ℓ²(FermConf)`. -/
def fermToLp (u : FermAlg) : FermFock :=
  ⟨fun α => u α, memLpTwo_of_finite_support u.finite_support⟩

@[simp] theorem fermToLp_apply (u : FermAlg) (α : FermConf) :
    ((fermToLp u : FermFock) : FermConf → ℂ) α = u α := rfl

theorem fermToLp_mem (u : FermAlg) : fermToLp u ∈ lpFiniteModes FermConf := u.finite_support

@[simp] theorem fermToLp_zero : fermToLp (0 : FermAlg) = 0 := by
  refine lp.ext (funext fun α => ?_)
  simp [fermToLp]

theorem fermToLp_add (x y : FermAlg) : fermToLp (x + y) = fermToLp x + fermToLp y := by
  refine lp.ext (funext fun α => ?_)
  simp [fermToLp]

theorem inner_fermToLp_of_subset {u : FermAlg} {s : Finset FermConf} (hs : u.support ⊆ s)
    (v : FermAlg) :
    (inner ℂ (fermToLp u) (fermToLp v) : ℂ) = ∑ α ∈ s, (starRingEnd ℂ) (u α) * v α := by
  rw [lp.inner_eq_tsum]
  have hcoord : ∀ α : FermConf,
      (inner ℂ (((fermToLp u : FermFock) : FermConf → ℂ) α)
        (((fermToLp v : FermFock) : FermConf → ℂ) α) : ℂ)
        = (starRingEnd ℂ) (u α) * v α := by
    intro α
    simp [RCLike.inner_apply, mul_comm]
  rw [tsum_congr hcoord]
  refine tsum_eq_sum fun α hα => ?_
  have hu : u α = 0 := by
    by_contra hc
    exact hα (hs (Finsupp.mem_support_iff.mpr hc))
  rw [hu, map_zero, zero_mul]

theorem inner_fermToLp_single (p q : FermConf) (a b : ℂ) :
    (inner ℂ (fermToLp (Finsupp.single p a)) (fermToLp (Finsupp.single q b)) : ℂ)
      = if q = p then (starRingEnd ℂ) a * b else 0 := by
  classical
  rw [inner_fermToLp_of_subset (s := {p}) Finsupp.support_single_subset, Finset.sum_singleton,
    Finsupp.single_eq_same, Finsupp.single_apply]
  by_cases h : q = p
  · simp [h]
  · simp [h]

/-- **The creation operator is the adjoint of the annihilation operator**:
`⟪ψ_j† u, v⟫ = ⟪u, ψ_j v⟫`. -/
theorem inner_fermCre_left (j : ℕ) (u v : FermAlg) :
    (inner ℂ (fermToLp (fermCre j u)) (fermToLp v) : ℂ)
      = inner ℂ (fermToLp u) (fermToLp (fermAnn j v)) := by
  classical
  induction u using Finsupp.induction_linear with
  | zero => rw [map_zero, fermToLp_zero, inner_zero_left, inner_zero_left]
  | add f g hf hg =>
      rw [map_add, fermToLp_add, fermToLp_add, inner_add_left, inner_add_left, hf, hg]
  | single β c =>
    induction v using Finsupp.induction_linear with
    | zero => rw [map_zero, fermToLp_zero, inner_zero_right, inner_zero_right]
    | add f g hf hg =>
        rw [map_add, fermToLp_add, fermToLp_add, inner_add_right, inner_add_right, hf, hg]
    | single α d =>
      by_cases hjb : j ∈ β
      · have h0 : fermCre j (Finsupp.single β c) = 0 := by simp [hjb]
        rw [h0, fermToLp_zero, inner_zero_left,
          inner_fermToLp_of_subset (s := {β}) Finsupp.support_single_subset,
          Finset.sum_singleton, fermAnn_apply, if_pos hjb, mul_zero]
      · have h1 : fermCre j (Finsupp.single β c)
            = Finsupp.single (insert j β) (c * jwSign j β) := by
          simp [hjb, Finsupp.smul_single]
        rw [h1, inner_fermToLp_single,
          inner_fermToLp_of_subset (s := {β}) Finsupp.support_single_subset,
          Finset.sum_singleton, Finsupp.single_eq_same, fermAnn_apply, if_neg hjb,
          Finsupp.single_apply]
        by_cases hα : α = insert j β
        · subst hα
          simp [map_mul, conj_jwSign]
          ring
        · simp [hα]

/-! ## E.4 — the `ℤ₂` grading and the superbracket -/

/-- **The total fermionic parity operator** `Γ = (−1)^F` on the fermionic Fock space. -/
def fermGrade : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (Finsupp.single β ((-1 : ℂ) ^ β.card))

@[simp] theorem fermGrade_single (β : FermConf) (c : ℂ) :
    fermGrade (Finsupp.single β c) = Finsupp.single β (((-1 : ℂ) ^ β.card) * c) := by
  simp [fermGrade, LinearMap.toSpanSingleton, Finsupp.smul_single, mul_comm]

theorem fermGrade_apply (u : FermAlg) (α : FermConf) :
    fermGrade u α = ((-1 : ℂ) ^ α.card) * u α := by
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => simp only [map_add, Finsupp.add_apply, hf, hg]; ring
  | single β c =>
    rw [fermGrade_single]
    by_cases h : α = β
    · subst h; simp
    · simp [h]

/-- The parity operator is an involution. -/
theorem fermGrade_involutive (u : FermAlg) : fermGrade (fermGrade u) = u := by
  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermGrade_apply, ← mul_assoc, ← pow_add]
  rcases Nat.even_or_odd α.card with he | ho
  · rw [Even.neg_one_pow (he.add he), one_mul]
  · rw [Even.neg_one_pow (ho.add_odd ho), one_mul]

/-- **The annihilation operator is odd**: `Γ ψ_j = − ψ_j Γ`. -/
theorem fermGrade_fermAnn (j : ℕ) (u : FermAlg) :
    fermGrade (fermAnn j u) = - fermAnn j (fermGrade u) := by
  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermAnn_apply, Finsupp.neg_apply, fermAnn_apply]
  by_cases hj : j ∈ α
  · simp [hj]
  · rw [if_neg hj, if_neg hj, fermGrade_apply, Finset.card_insert_of_notMem hj, pow_succ]
    ring

/-- **The creation operator is odd**: `Γ ψ_j† = − ψ_j† Γ`. -/
theorem fermGrade_fermCre (j : ℕ) (u : FermAlg) :
    fermGrade (fermCre j u) = - fermCre j (fermGrade u) := by
  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermCre_apply, Finsupp.neg_apply, fermCre_apply]
  by_cases hj : j ∈ α
  · rw [if_pos hj, if_pos hj, fermGrade_apply, Finset.card_erase_of_mem hj]
    have hc : 1 ≤ α.card := Finset.card_pos.mpr ⟨j, hj⟩
    have hpow : ((-1 : ℂ)) ^ α.card = -((-1 : ℂ) ^ (α.card - 1)) := by
      conv_lhs => rw [show α.card = (α.card - 1) + 1 from by omega]
      rw [pow_succ]
      ring
    rw [hpow]
    ring
  · simp [hj]

/-- The sign `(−1)^{pq}` of the superalgebra: `−1` exactly when both degrees are odd. -/
def sgnDeg (p q : ZMod 2) : ℂ := if p = 1 ∧ q = 1 then -1 else 1

/-- **The graded (super) bracket** `[x, y} = xy − (−1)^{|x||y|} yx` of two operators of
degrees `p` and `q`. -/
def superBracket {V : Type*} [AddCommGroup V] [Module ℂ V] (p q : ZMod 2)
    (A B : V →ₗ[ℂ] V) : V →ₗ[ℂ] V :=
  A ∘ₗ B - sgnDeg p q • (B ∘ₗ A)

theorem superBracket_apply {V : Type*} [AddCommGroup V] [Module ℂ V] (p q : ZMod 2)
    (A B : V →ₗ[ℂ] V) (x : V) :
    superBracket p q A B x = A (B x) - sgnDeg p q • B (A x) := rfl

/-- For two odd operators the superbracket is the **anticommutator**. -/
theorem superBracket_odd_odd {V : Type*} [AddCommGroup V] [Module ℂ V]
    (A B : V →ₗ[ℂ] V) (x : V) : superBracket 1 1 A B x = A (B x) + B (A x) := by
  rw [superBracket_apply, sgnDeg, if_pos ⟨rfl, rfl⟩]
  simp

/-- For an even and an odd operator the superbracket is the **commutator**. -/
theorem superBracket_even_odd {V : Type*} [AddCommGroup V] [Module ℂ V]
    (A B : V →ₗ[ℂ] V) (x : V) : superBracket 0 1 A B x = A (B x) - B (A x) := by
  rw [superBracket_apply, sgnDeg, if_neg (by decide)]
  simp

/-- **E.4/E.3 — the CAR as a superbracket**: `[ψ_j, ψ_j†} = 1`. -/
theorem superBracket_fermAnn_fermCre (j : ℕ) :
    superBracket 1 1 (fermAnn j) (fermCre j) = LinearMap.id := by
  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermAnn_fermCre]
  rfl

/-- `[ψ_j, ψ_k†} = 0` for `j ≠ k`. -/
theorem superBracket_fermAnn_fermCre_of_ne {j k : ℕ} (h : j ≠ k) :
    superBracket 1 1 (fermAnn j) (fermCre k) = 0 := by
  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermAnn_fermCre_of_ne h]
  rfl

/-- `[ψ_j, ψ_k} = 0`. -/
theorem superBracket_fermAnn_fermAnn (j k : ℕ) :
    superBracket 1 1 (fermAnn j) (fermAnn k) = 0 := by
  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermAnn_fermAnn]
  rfl

/-- `[ψ_j†, ψ_k†} = 0`. -/
theorem superBracket_fermCre_fermCre (j k : ℕ) :
    superBracket 1 1 (fermCre j) (fermCre k) = 0 := by
  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermCre_fermCre]
  rfl

/-! ## The graded state space `Γˢ ⊗ Γᵃ` -/

/-- **The graded (bosonic ⊗ ghost) algebraic state space** of the book's Hilbert space
`Γˢ(L²(ℝ⁸⁴ × ℤ₂¹⁹)) ⊗ Γᵃ(L²(ℝ⁸⁴ × ℤ₂¹⁹))`. -/
abbrev QGGraded := TensorProduct ℂ BoseAlg FermAlg

/-- A bosonic operator acting on the graded state space. -/
def bosOp (A : BoseAlg →ₗ[ℂ] BoseAlg) : QGGraded →ₗ[ℂ] QGGraded :=
  TensorProduct.map A LinearMap.id

/-- A ghost (fermionic) operator acting on the graded state space. -/
def ghostOp (B : FermAlg →ₗ[ℂ] FermAlg) : QGGraded →ₗ[ℂ] QGGraded :=
  TensorProduct.map LinearMap.id B

@[simp] theorem bosOp_tmul (A : BoseAlg →ₗ[ℂ] BoseAlg) (x : BoseAlg) (y : FermAlg) :
    bosOp A (x ⊗ₜ[ℂ] y) = (A x) ⊗ₜ[ℂ] y := rfl

@[simp] theorem ghostOp_tmul (B : FermAlg →ₗ[ℂ] FermAlg) (x : BoseAlg) (y : FermAlg) :
    ghostOp B (x ⊗ₜ[ℂ] y) = x ⊗ₜ[ℂ] (B y) := rfl

/-- **Bosonic and ghost operators commute** on the graded state space: they act on
different tensor factors, and the bosonic ones are even. -/
theorem bosOp_ghostOp_comm (A : BoseAlg →ₗ[ℂ] BoseAlg) (B : FermAlg →ₗ[ℂ] FermAlg)
    (z : QGGraded) : bosOp A (ghostOp B z) = ghostOp B (bosOp A z) := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y => simp
  | add z w hz hw => simp [map_add, hz, hw]

/-- The superbracket of a bosonic (even) and a ghost (odd) operator vanishes. -/
theorem superBracket_bosOp_ghostOp (A : BoseAlg →ₗ[ℂ] BoseAlg) (B : FermAlg →ₗ[ℂ] FermAlg) :
    superBracket 0 1 (bosOp A) (ghostOp B) = 0 := by
  refine LinearMap.ext fun z => ?_
  rw [superBracket_even_odd, bosOp_ghostOp_comm, sub_self]
  rfl

/-- **The bosonic CCR on the graded state space**: `[a_j, a_j†] = 1`. -/
theorem qgCCR (j : ℕ) (z : QGGraded) :
    bosOp (annA j) (bosOp (creA j) z) - bosOp (creA j) (bosOp (annA j) z) = z := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [bosOp_tmul]
      rw [← TensorProduct.sub_tmul, ccr_annA_creA]
  | add z w hz hw =>
      simp only [map_add]
      rw [show bosOp (annA j) (bosOp (creA j) z) + bosOp (annA j) (bosOp (creA j) w)
            - (bosOp (creA j) (bosOp (annA j) z) + bosOp (creA j) (bosOp (annA j) w))
          = (bosOp (annA j) (bosOp (creA j) z) - bosOp (creA j) (bosOp (annA j) z))
            + (bosOp (annA j) (bosOp (creA j) w) - bosOp (creA j) (bosOp (annA j) w)) by abel,
        hz, hw]

/-- **The ghost CAR on the graded state space**: `{ψ_j, ψ_j†} = 1`. -/
theorem qgGhostCar (j : ℕ) (z : QGGraded) :
    ghostOp (fermAnn j) (ghostOp (fermCre j) z) + ghostOp (fermCre j) (ghostOp (fermAnn j) z)
      = z := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [ghostOp_tmul]
      rw [← TensorProduct.tmul_add, car_fermAnn_fermCre]
  | add z w hz hw =>
      simp only [map_add]
      rw [show ghostOp (fermAnn j) (ghostOp (fermCre j) z)
              + ghostOp (fermAnn j) (ghostOp (fermCre j) w)
            + (ghostOp (fermCre j) (ghostOp (fermAnn j) z)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) w))
          = (ghostOp (fermAnn j) (ghostOp (fermCre j) z)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) z))
            + (ghostOp (fermAnn j) (ghostOp (fermCre j) w)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) w)) by abel,
        hz, hw]

/-- The off-diagonal ghost CAR on the graded state space: `{ψ_j, ψ_k†} = 0`, `j ≠ k`. -/
theorem qgGhostCar_of_ne {j k : ℕ} (h : j ≠ k) (z : QGGraded) :
    ghostOp (fermAnn j) (ghostOp (fermCre k) z) + ghostOp (fermCre k) (ghostOp (fermAnn j) z)
      = 0 := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [ghostOp_tmul]
      rw [← TensorProduct.tmul_add, car_fermAnn_fermCre_of_ne h, TensorProduct.tmul_zero]
  | add z w hz hw =>
      simp only [map_add]
      rw [show ghostOp (fermAnn j) (ghostOp (fermCre k) z)
              + ghostOp (fermAnn j) (ghostOp (fermCre k) w)
            + (ghostOp (fermCre k) (ghostOp (fermAnn j) z)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) w))
          = (ghostOp (fermAnn j) (ghostOp (fermCre k) z)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) z))
            + (ghostOp (fermAnn j) (ghostOp (fermCre k) w)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) w)) by abel,
        hz, hw, add_zero]

/-- **The total `ℤ₂` grading** of the graded state space: the fermionic parity, extended
by the identity on the bosonic factor. -/
def qgGrade : QGGraded →ₗ[ℂ] QGGraded := ghostOp fermGrade

theorem qgGrade_involutive (z : QGGraded) : qgGrade (qgGrade z) = z := by
  induction z using TensorProduct.induction_on with
  | zero => simp [qgGrade]
  | tmul x y => simp [qgGrade, fermGrade_involutive]
  | add z w hz hw => rw [map_add, map_add, hz, hw]

/-- **The bosonic operators are even** for the total grading. -/
theorem bosOp_even (A : BoseAlg →ₗ[ℂ] BoseAlg) (z : QGGraded) :
    qgGrade (bosOp A z) = bosOp A (qgGrade z) :=
  (bosOp_ghostOp_comm A fermGrade z).symm

/-- **The ghost ladder operators are odd** for the total grading. -/
theorem ghostOp_odd_ann (j : ℕ) (z : QGGraded) :
    qgGrade (ghostOp (fermAnn j) z) = - ghostOp (fermAnn j) (qgGrade z) := by
  induction z using TensorProduct.induction_on with
  | zero => simp [qgGrade]
  | tmul x y =>
      simp only [qgGrade, ghostOp_tmul, fermGrade_fermAnn]
      rw [TensorProduct.tmul_neg]
  | add z w hz hw =>
      simp only [map_add, hz, hw]
      abel

theorem ghostOp_odd_cre (j : ℕ) (z : QGGraded) :
    qgGrade (ghostOp (fermCre j) z) = - ghostOp (fermCre j) (qgGrade z) := by
  induction z using TensorProduct.induction_on with
  | zero => simp [qgGrade]
  | tmul x y =>
      simp only [qgGrade, ghostOp_tmul, fermGrade_fermCre]
      rw [TensorProduct.tmul_neg]
  | add z w hz hw =>
      simp only [map_add, hz, hw]
      abel

/-! ## The `19` diffeomorphism ghosts of the book

`ℤ₂¹⁹` = 4 diffeomorphism ghosts `ψ_μ` + 16 ghost derivatives `∂_μ ψ_ν` − 1. -/

/-- The number of ghost modes of the book's gravity Fock space. -/
def qgGhostModes : ℕ := 19

theorem qgGhostModes_eq : qgGhostModes = 4 + 16 - 1 := rfl

/-- The CAR for the `19` book ghosts, as a special case. -/
theorem qgGhostCar_book (a b : Fin qgGhostModes) (z : QGGraded) :
    ghostOp (fermAnn a.val) (ghostOp (fermCre b.val) z)
        + ghostOp (fermCre b.val) (ghostOp (fermAnn a.val) z)
      = if a = b then z else 0 := by
  by_cases h : a = b
  · subst h; rw [if_pos rfl, qgGhostCar]
  · rw [if_neg h, qgGhostCar_of_ne (by simpa [Fin.val_inj] using h)]

/-! ## E.5, E.5b, E.6 — the graded Fock Hamiltonian and its essential self-adjointness -/

/-- The joint occupation index of the graded Fock space: a bosonic configuration together
with a ghost configuration. -/
abbrev GradedIdx := BoseConf × FermConf

/-- The total ghost energy of a ghost configuration. -/
def ghostEnergy (g : ℕ → ℝ) (α : FermConf) : ℝ := ∑ a ∈ α, g a

@[simp] theorem ghostEnergy_empty (g : ℕ → ℝ) : ghostEnergy g (∅ : FermConf) = 0 := by
  simp [ghostEnergy]

theorem ghostEnergy_insert {g : ℕ → ℝ} {a : ℕ} {α : FermConf} (h : a ∉ α) :
    ghostEnergy g (insert a α) = g a + ghostEnergy g α := by
  simp [ghostEnergy, Finset.sum_insert h]

/-- **The symbol of the graded Fock Hamiltonian**: the total boson energy `∑ₖ nₖ ωₖ` plus
the total ghost energy `∑_{a ∈ α} gₐ` of the joint occupation state.  Neither energy is
assumed bounded, bounded below, or of a fixed sign — the gauge-fixed gravity symbol is
indefinite. -/
def qgGradedSymbol (omega g : ℕ → ℝ) : GradedIdx → ℝ :=
  fun p => BookProof.NavierStokesFlow.FockOfFock.confEnergy omega p.1 + ghostEnergy g p.2

/-- The vacuum has zero energy. -/
@[simp] theorem qgGradedSymbol_vacuum (omega g : ℕ → ℝ) :
    qgGradedSymbol omega g (0, (∅ : FermConf)) = 0 := by
  simp [qgGradedSymbol, BookProof.NavierStokesFlow.FockOfFock.confEnergy_zero]

/-- A one-ghost state carries exactly the energy of its ghost mode. -/
theorem qgGradedSymbol_oneGhost (omega g : ℕ → ℝ) (a : ℕ) :
    qgGradedSymbol omega g (0, ({a} : FermConf)) = g a := by
  simp [qgGradedSymbol, BookProof.NavierStokesFlow.FockOfFock.confEnergy_zero, ghostEnergy]

/-- **The graded Fock Hamiltonian** `dΓ(ω) ⊗ 1 + 1 ⊗ dΓ(g)`, as the diagonal operator with
symbol `qgGradedSymbol` on the finite-occupation domain of `ℓ²(GradedIdx)`. -/
def qgGradedHam (omega g : ℕ → ℝ) :
    lpFiniteModes GradedIdx →ₗ[ℂ] lpFiniteModes GradedIdx :=
  lpDiag (qgGradedSymbol omega g)

theorem qgGradedHam_isSymmetricDom (omega g : ℕ → ℝ) :
    IsSymmetricDom (qgGradedHam omega g) :=
  lpDiag_isSymmetricDom _

theorem qgGradedHam_symmetricOn (omega g : ℕ → ℝ) :
    SymmetricOn (lpFiniteModes GradedIdx)
      ((lpFiniteModes GradedIdx).subtype.comp (qgGradedHam omega g)) :=
  fun x y => lpDiag_isSymmetricDom _ x y

/-- **E.5 — essential self-adjointness of the graded (boson ⊗ ghost) Fock Hamiltonian.**
No boundedness, no positivity, no relative bound: the joint occupation states are a total
family of eigenvectors with real eigenvalues. -/
theorem qgGradedFock_esa (omega g : ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes GradedIdx) (qgGradedHam omega g) :=
  lpDiag_hasZeroDeficiencyOn _

theorem qgGradedFock_essentiallySelfAdjointOn (omega g : ℕ → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes GradedIdx)
      ((lpFiniteModes GradedIdx).subtype.comp (qgGradedHam omega g)) :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).2 (qgGradedFock_esa omega g)

/-- **The unitary group of the graded Fock Hamiltonian.**  Essential self-adjointness on
the dense finite-occupation domain selects one self-adjoint operator, and Stone's theorem
turns it into the group `e^{−itH}` solving the Schrödinger equation globally in time. -/
theorem qgGradedFock_stone_flow (omega g : ℕ → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (lp (fun _ : GradedIdx => ℂ) 2))
      (U : ℝ → (lp (fun _ : GradedIdx => ℂ) 2 →L[ℂ] lp (fun _ : GradedIdx => ℂ) 2)),
      IsSelfAdjointExtension
        ((lpFiniteModes GradedIdx).subtype.comp (qgGradedHam omega g)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ lpFiniteModes_dense (qgGradedHam_symmetricOn omega g)
    (qgGradedFock_essentiallySelfAdjointOn omega g)

/-- The graded Fock Hamiltonian is genuinely unbounded as soon as the ghost energies are
unbounded — essential self-adjointness above is not a boundedness phenomenon. -/
theorem qgGradedFock_not_bounded (omega g : ℕ → ℝ) (homega : omega = 0)
    (hg : ∀ C : ℝ, ∃ a, C < |g a|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes GradedIdx, ‖qgGradedHam omega g f‖ ≤ C * ‖f‖ := by
  refine lpDiag_not_bounded _ fun C => ?_
  obtain ⟨a, ha⟩ := hg C
  refine ⟨(0, ({a} : FermConf)), ?_⟩
  rwa [show qgGradedSymbol omega g (0, ({a} : FermConf)) = g a by
    simp [qgGradedSymbol, homega, BookProof.NavierStokesFlow.FockOfFock.confEnergy, ghostEnergy]]

/-! ### The general second-quantization theorems the plan asks to reuse -/

/-- **E.5 (reuse) — the second quantization of an arbitrary real one-particle symbol is
essentially self-adjoint** on the finite-particle domain, with no positivity or
boundedness assumption.  This is the bosonic half of the graded statement above. -/
theorem qgDGamma_esa (omega : ℕ → ℝ) :
    HasZeroDeficiencyOn (BookProof.NavierStokesFlow.FockOfFock.FockDom ℕ)
      (BookProof.NavierStokesFlow.FockOfFock.dGamma omega) :=
  BookProof.NavierStokesFlow.FockOfFock.dGamma_hasZeroDeficiencyOn omega

/-- **E.5b (reuse) — the two-level (Fock-of-Fock) Hamiltonian is essentially
self-adjoint**, with no boundedness at either level. -/
theorem qgTwoLevel_esa (ext eps : ℕ → ℝ) :
    HasZeroDeficiencyOn (BookProof.NavierStokesFlow.FockOfFock.FockOfFockDom ℕ ℕ)
      (BookProof.NavierStokesFlow.FockOfFock.hTwoLevel ext eps) :=
  BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_hasZeroDeficiencyOn ext eps

/-- **E.6 (reuse) — the Hashimoto/SIRK shift-invert limit selects the Friedrichs extension
of the second quantization** of a symmetric positive one-particle operator on the
Gauss–polynomial core of `L²(ℝ⁸⁴)`, the gravity field-space core. -/
theorem qgFock_hashimoto_selects (e84 : ℕ ≃ (Fin 84 →₀ ℕ)) (eps : ℕ ≃ BoseConf)
    (A : finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84) →ₗ[ℂ]
      finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84))
    (hA : SymmetricOn (finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84))
      ((finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84)).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm
      ((finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84)).subtype.comp A) x)
    {gamma : ℝ} (hgamma : 0 < gamma) :
    ∃ (Dom : Submodule ℂ BookProof.FockSecondQuantization.Fock)
      (A' : Dom →ₗ[ℂ] BookProof.FockSecondQuantization.Fock)
      (R : BookProof.FockSecondQuantization.Fock →L[ℂ] BookProof.FockSecondQuantization.Fock),
      IsPositiveSelfAdjointExtension
        (dGammaOpB eps (opCol (BookProof.HermiteProductCore.coreBasis e84) A)) A' ∧
        IsShiftInvert A' gamma R ∧ ‖R‖ ≤ gamma⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : BookProof.FockSecondQuantization.Fock,
          Filter.Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN eps) k u)
            Filter.atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : BookProof.FockSecondQuantization.Fock,
          Filter.Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN eps) k) z u)
            Filter.atTop (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ BookProof.FockSecondQuantization.Fock)
          (A'' : Dom' →ₗ[ℂ] BookProof.FockSecondQuantization.Fock),
          IsShiftInvert A'' gamma R →
            Dom' = Dom ∧ ∀ (x : BookProof.FockSecondQuantization.Fock) (hx : x ∈ Dom)
              (hx' : x ∈ Dom'), A'' ⟨x, hx'⟩ = A' ⟨x, hx⟩) :=
  secondQuantization_hashimoto_selects eps (BookProof.HermiteProductCore.coreBasis e84) A hA
    hpos hgamma

end

end BookProof.QuantumGravityFock
