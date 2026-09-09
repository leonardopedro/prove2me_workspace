import Mathlib
import BookProof.ChapterFockSchurEsa

/-!
# `dΓ(A)` for an **unbounded** one-particle operator: the Schur gate weighted by the
# one-particle symbol

`BookProof.ChapterFockSchurEsa` proves the number bound `‖dΓ(A)u‖ ≤ K‖𝒩u‖` and essential
self-adjointness of `dΓ(A)` on the finite-occupation core under the **unweighted Schur
gate** `∑_j |A_{kj}| ≤ K` — a gate that forces the one-particle operator `A` to be
*bounded*.  The recorded next step was `dΓ` of an **unbounded** one-particle operator,
through "a Schur gate weighted by the one-particle symbol".  That is what this module
supplies.

Fix a **weight** `w : ℕ → ℝ` with `w k ≥ 1` — the one-particle symbol — and let

```text
𝒩_w = dΓ(diag (w²)),      σ(α) = ∑_k w_k² α_k + 1
```

be the weighted number operator and its symbol.  The gate is

```text
(row)   ∀ k, ∑_j |A_{kj}| ≤ K w_k,
(col)   ∀ j, ∑_k |A_{jk}| / w_k ≤ K,
(comm)  ∀ k, ∑_j |A_{kj}| · |w_j² − w_k²| / (w_k w_j) ≤ B.
```

For `w ≡ 1` this is the unweighted Schur gate with a vanishing commutator gate, so the
present statement contains the bounded one; but the row gate now allows the rows of `A`
to *grow* like the symbol, and the witness of section 7 — the one-particle matrix
`A_{k,k+1} = A_{k+1,k} = √(k+1)`, the position operator of a harmonic oscillator — is
genuinely unbounded and covered.

## What is proved

* `wdeg`, `wSym`, `wgt` — the weighted particle number `∑_k w_k² α_k`, the comparison
  symbol `σ = wdeg + 1` and the associated diagonal operator on the core.
* `annA_wgt` — the commutation relation `a_j 𝒩_w = (𝒩_w + w_j²) a_j`, the only algebraic
  input of the commutator estimate.
* `sum_wsq_normSq_annA` — `∑_k w_k² ‖a_k u‖² = ⟪u, 𝒩_w u⟫`, the weighted form of the
  identity behind the number bound.
* **`norm_dGamma_le_w`** — the relative bound `‖dΓ(A)u‖ ≤ K‖σ u‖` on the core, proved
  sector by sector: `dΓ(A)` conserves the particle number, so on the `n`-particle sector
  the weighted Schur test gives `‖dΓ(A)u‖² ≤ K² n ⟪u, 𝒩_w u⟫`, and `n ≤ wdeg` because
  `w ≥ 1`.
* **`dGammaOp_commForm_bound_w`** — the commutator estimate
  `|⟪u, i[dΓ(A), σ]u⟫| ≤ B⟪u, σ u⟫`: the part of `⟪dΓ(A)u, σu⟫` that survives conjugation
  is `∑_{k,j} conj(A_{kj})(w_j² − w_k²)⟪a_k u, a_j u⟫`, which the commutator gate controls
  by the same Schur test.
* **`dGamma_essentiallySelfAdjointOn_core_w`** — the headline: `dΓ(A)` is essentially
  self-adjoint on the finite-occupation core, and `dGamma_stone_flow_w` — its unitary
  group.
* `oscCol`, `isHermCol_oscCol`, `wRow_oscCol`, `wCol_oscCol`, `wComm_oscCol`,
  **`oscCol_not_schurBound`**, `oscCol_entry_atTop`, **`osc_essentiallySelfAdjointOn_core`**
  — the non-vacuity witness: an *unbounded* one-particle matrix (no unweighted Schur bound
  holds, and its entries tend to infinity) whose second quantization is covered.

## Honest boundary

The one-particle matrix must still be Hermitian and column-finite; what is removed is its
boundedness.  The three gates are conditions on the matrix *relative to the chosen symbol*
`w`; nothing here chooses `w` for a given Hamiltonian.  Everything is `sorry`-free and
`axiom`-free.
-/

namespace BookProof.FockWeightedSchur

open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The weighted particle number -/

/-- The **weighted particle number** `∑_k w_k² α_k` of a configuration. -/
def wdeg (w : ℕ → ℝ) (α : Conf) : ℝ := α.sum fun k n => w k ^ 2 * n

/-- The comparison symbol `σ(α) = ∑_k w_k² α_k + 1`. -/
def wSym (w : ℕ → ℝ) (α : Conf) : ℝ := wdeg w α + 1

variable {w : ℕ → ℝ}

theorem wdeg_eq_sum {α : Conf} {S : Finset ℕ} (h : α.support ⊆ S) :
    wdeg w α = ∑ k ∈ S, w k ^ 2 * α k :=
  Finsupp.sum_of_support_subset α h _ (by simp)

theorem wdeg_nonneg (α : Conf) : 0 ≤ wdeg w α := by
  rw [wdeg_eq_sum (Finset.Subset.refl α.support)]
  refine Finset.sum_nonneg fun k _ => ?_
  have : (0:ℝ) ≤ w k ^ 2 := sq_nonneg _
  have h2 : (0:ℝ) ≤ (α k : ℝ) := Nat.cast_nonneg _
  positivity

theorem wSym_nonneg (α : Conf) : 0 ≤ wSym w α := by
  have := wdeg_nonneg (w := w) α
  simp only [wSym]; linarith

theorem wSym_pos (α : Conf) : 0 < wSym w α := by
  have := wdeg_nonneg (w := w) α
  simp only [wSym]; linarith

/-- The unweighted particle number is dominated by the weighted one. -/
theorem ndeg_le_wdeg (hw : ∀ k, 1 ≤ w k) (α : Conf) : (ndeg α : ℝ) ≤ wdeg w α := by
  rw [wdeg_eq_sum (Finset.Subset.refl α.support), ndeg_eq_sum (Finset.Subset.refl α.support)]
  push_cast
  refine Finset.sum_le_sum fun k _ => ?_
  have h1 : (1:ℝ) ≤ w k ^ 2 := by nlinarith [hw k]
  have h2 : (0:ℝ) ≤ (α k : ℝ) := Nat.cast_nonneg _
  nlinarith

theorem wdeg_up (j : ℕ) (α : Conf) : wdeg w (up j α) = wdeg w α + w j ^ 2 := by
  classical
  have h1 : (up j α).support ⊆ insert j α.support := support_up j α
  have h2 : α.support ⊆ insert j α.support := Finset.subset_insert _ _
  rw [wdeg_eq_sum h1, wdeg_eq_sum h2]
  have hcongr : ∀ i ∈ insert j α.support,
      w i ^ 2 * (((up j α) i : ℕ) : ℝ)
        = w i ^ 2 * ((α i : ℕ) : ℝ) + (if i = j then w j ^ 2 else 0) := by
    intro i _
    rw [up_apply' j α i]
    by_cases h : i = j
    · subst h; push_cast; simp; ring
    · simp [h]
  rw [Finset.sum_congr rfl hcongr, Finset.sum_add_distrib]
  congr 1
  simp

theorem wSym_up (j : ℕ) (α : Conf) : wSym w (up j α) = wSym w α + w j ^ 2 := by
  simp only [wSym, wdeg_up]; ring

/-! ## 2. The weighted number operator on the core -/

/-- The comparison operator `𝒩_w + 1` applied to a finitely supported state. -/
def wgt (w : ℕ → ℝ) (u : FockAlg) : FockAlg :=
  Finsupp.onFinset u.support (fun α => (wSym w α : ℂ) * u α) (by
    intro α hα
    by_contra hc
    have hz : u α = 0 := Finsupp.notMem_support_iff.mp hc
    simp only [hz, mul_zero, ne_eq, not_true_eq_false] at hα)

theorem wgt_apply (u : FockAlg) (α : Conf) : wgt w u α = (wSym w α : ℂ) * u α := rfl

theorem support_wgt_subset (u : FockAlg) : (wgt w u).support ⊆ u.support :=
  Finsupp.support_onFinset_subset

/-- **The commutation relation `a_j 𝒩_w = (𝒩_w + w_j²) a_j`.** -/
theorem annA_wgt (j : ℕ) (u : FockAlg) :
    annA j (wgt w u) = wgt w (annA j u) + ((w j ^ 2 : ℝ) : ℂ) • annA j u := by
  refine Finsupp.ext fun α => ?_
  rw [annA_apply, wgt_apply, Finsupp.add_apply, wgt_apply, annA_apply, Finsupp.smul_apply,
    annA_apply, smul_eq_mul, wSym_up]
  push_cast
  ring

/-- The weighted number operator is symmetric on the core. -/
theorem inner_wgt_symm (u v : FockAlg) :
    (inner ℂ (toLp (wgt w u)) (toLp v) : ℂ) = inner ℂ (toLp u) (toLp (wgt w v)) := by
  classical
  have hsu : (wgt w u).support ⊆ u.support ∪ v.support :=
    (support_wgt_subset u).trans Finset.subset_union_left
  have hsv : u.support ⊆ u.support ∪ v.support := Finset.subset_union_left
  rw [inner_toLp_of_subset hsu v, inner_toLp_of_subset hsv (wgt w v)]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [wgt_apply, wgt_apply, map_mul, Complex.conj_ofReal]
  ring

/-- The quadratic form of the comparison operator. -/
theorem re_inner_wgt (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (wgt w u)) : ℂ).re = ∑ α ∈ u.support, wSym w α * ‖u α‖ ^ 2 := by
  classical
  rw [inner_toLp u (wgt w u)]
  have hterm : ∀ α : Conf, (starRingEnd ℂ) (u α) * (wgt w u) α
      = ((wSym w α * ‖u α‖ ^ 2 : ℝ) : ℂ) := by
    intro α
    rw [wgt_apply]
    have : (starRingEnd ℂ) (u α) * u α = ((‖u α‖ ^ 2 : ℝ) : ℂ) := by
      rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]
    push_cast
    rw [show (starRingEnd ℂ) (u α) * ((wSym w α : ℂ) * u α)
        = (wSym w α : ℂ) * ((starRingEnd ℂ) (u α) * u α) from by ring, this]
    push_cast
    ring
  rw [Finset.sum_congr rfl (fun α _ => hterm α), ← Complex.ofReal_sum, Complex.ofReal_re]

/-- **`∑_k w_k² ‖a_k u‖² = ⟪u, 𝒩_w u⟫`.** -/
theorem sum_wsq_normSq_annA {u : FockAlg} {L : Finset ℕ} (hL : modes u ⊆ L) :
    ∑ k ∈ L, w k ^ 2 * ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 := by
  classical
  rw [Finset.sum_congr rfl (fun k _ => by rw [normSq_annA k u, Finset.mul_sum]),
    Finset.sum_comm]
  refine Finset.sum_congr rfl fun α hα => ?_
  have hsub : α.support ⊆ L := fun i hi => hL (support_subset_modes hα hi)
  rw [wdeg_eq_sum hsub, Finset.sum_mul]
  exact Finset.sum_congr rfl fun k _ => by ring

/-! ## 3. The weighted Schur gates -/

variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

/-- The **row gate**: the rows of the one-particle matrix grow at most like the symbol. -/
def WRowBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (K : ℝ) : Prop :=
  ∀ k, ∑ j ∈ (col k).support, ‖(col k) j‖ ≤ K * w k

/-- The **column gate**: the columns, weighted by the reciprocal symbol, are summable. -/
def WColBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (K : ℝ) : Prop :=
  ∀ j, ∑ k ∈ (col j).support, ‖(col j) k‖ / w k ≤ K

/-- The **commutator gate**: the matrix of `[A, diag w²]`, weighted by `1/(w_k w_j)`, has
bounded rows. -/
def WCommBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (B : ℝ) : Prop :=
  ∀ k, ∑ j ∈ (col k).support, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ B

theorem sum_le_of_vanishing {f : ℕ → ℝ} {S L : Finset ℕ} (hf : ∀ j, 0 ≤ f j)
    (hz : ∀ j, j ∉ S → f j = 0) : ∑ j ∈ L, f j ≤ ∑ j ∈ S, f j := by
  classical
  have h1 : ∑ j ∈ L, f j = ∑ j ∈ L ∩ S, f j := by
    refine (Finset.sum_subset Finset.inter_subset_left ?_).symm
    intro j hj hjn
    exact hz j fun hs => hjn (Finset.mem_inter.mpr ⟨hj, hs⟩)
  rw [h1]
  exact Finset.sum_le_sum_of_subset_of_nonneg Finset.inter_subset_right fun j _ _ => hf j

theorem w_pos (hw : ∀ k, 1 ≤ w k) (k : ℕ) : 0 < w k := lt_of_lt_of_le zero_lt_one (hw k)

/-- The row gate, on an arbitrary finite set of modes. -/
theorem wrow_le (hw : ∀ k, 1 ≤ w k) (hK : WRowBound w col K) (k : ℕ) (L : Finset ℕ) :
    ∑ j ∈ L, ‖(col k) j‖ / w k ≤ K := by
  classical
  have hwk : 0 < w k := w_pos hw k
  refine le_trans (sum_le_of_vanishing (S := (col k).support)
    (fun j => div_nonneg (norm_nonneg _) hwk.le) ?_) ?_
  · intro j hj
    rw [Finsupp.notMem_support_iff.mp hj]
    simp
  · rw [← Finset.sum_div, div_le_iff₀ hwk]
    exact le_trans (hK k) (le_of_eq (by ring))

/-- The column gate, on an arbitrary finite set of modes. -/
theorem wcol_le (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col) (hK : WColBound w col K) (j : ℕ)
    (L : Finset ℕ) : ∑ k ∈ L, ‖(col k) j‖ / w k ≤ K := by
  classical
  have hswap : ∀ k, ‖(col k) j‖ = ‖(col j) k‖ := by
    intro k
    rw [hherm j k]
    simp
  rw [Finset.sum_congr rfl fun k _ => by rw [hswap k]]
  refine le_trans (sum_le_of_vanishing (S := (col j).support)
    (fun k => div_nonneg (norm_nonneg _) (w_pos hw k).le) ?_) (hK j)
  intro k hk
  rw [Finsupp.notMem_support_iff.mp hk]
  simp

/-- A commutator gate is non-negative. -/
theorem wcomm_nonneg (hw : ∀ k, 1 ≤ w k) (hB : WCommBound w col B) : 0 ≤ B :=
  le_trans (Finset.sum_nonneg (s := (col 0).support)
    (f := fun j => ‖(col 0) j‖ * |w j ^ 2 - w 0 ^ 2| / (w 0 * w j)) fun j _ => by
      have : 0 < w 0 * w j := mul_pos (w_pos hw 0) (w_pos hw j)
      positivity) (hB 0)

/-- The commutator gate, on an arbitrary finite set of modes: the rows. -/
theorem wcomm_row_le (hw : ∀ k, 1 ≤ w k) (hB : WCommBound w col B) (k : ℕ) (L : Finset ℕ) :
    ∑ j ∈ L, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ B := by
  classical
  refine le_trans (sum_le_of_vanishing (S := (col k).support) (fun j => ?_) ?_) (hB k)
  · have : 0 < w k * w j := mul_pos (w_pos hw k) (w_pos hw j)
    positivity
  · intro j hj
    rw [Finsupp.notMem_support_iff.mp hj]
    simp

/-- The commutator gate, on an arbitrary finite set of modes: the columns. -/
theorem wcomm_col_le (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col) (hB : WCommBound w col B)
    (j : ℕ) (L : Finset ℕ) :
    ∑ k ∈ L, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ B := by
  classical
  have hterm : ∀ k, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j)
      = ‖(col j) k‖ * |w k ^ 2 - w j ^ 2| / (w j * w k) := by
    intro k
    have h1 : ‖(col k) j‖ = ‖(col j) k‖ := by rw [hherm j k]; simp
    rw [h1, abs_sub_comm, mul_comm (w k) (w j)]
  rw [Finset.sum_congr rfl fun k _ => hterm k]
  exact wcomm_row_le hw hB j L

/-! ## 4. The relative bound, sector by sector -/

/-- **The weighted number bound on one sector.**  On the `n`-particle sector,
`‖dΓ(A)u‖² ≤ K² n ⟪u, 𝒩_w u⟫`. -/
theorem normSq_dGamma_le_of_sector (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ((n : ℝ) * ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2) := by
  classical
  set v : FockAlg := dGamma col u with hv
  have hvsec : InSector n v := dGamma_inSector col hu
  set L : Finset ℕ := closureModes col u v with hLdef
  set Q : ℝ := ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 with hQdef
  have hQ0 : 0 ≤ Q := Finset.sum_nonneg fun α _ =>
    mul_nonneg (wdeg_nonneg α) (sq_nonneg _)
  have hexp : (inner ℂ (toLp v) (toLp v) : ℂ)
      = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
          * inner ℂ (toLp (annA k u)) (toLp (annA j v)) :=
    inner_dGamma_left col u v (modes_left_subset_closure col u v)
      (col_support_subset_closure col u v)
  have hbound : ‖toLp v‖ ^ 2 ≤ ∑ k ∈ L, ∑ j ∈ L,
      ‖(col k) j‖ * (‖toLp (annA k u)‖ * ‖toLp (annA j v)‖) := by
    have h0 : ((‖toLp v‖ ^ 2 : ℝ) : ℂ) = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
        * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
      rw [← hexp, inner_self_eq_norm_sq_to_K]
      norm_cast
    have h1 : ‖toLp v‖ ^ 2 = ‖(∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
        * inner ℂ (toLp (annA k u)) (toLp (annA j v)) : ℂ)‖ := by
      rw [← h0, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
    rw [h1]
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
    rw [norm_mul, RCLike.norm_conj]
    exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _) (norm_nonneg _)
  have hschur := schur_test (L := L) (m := fun k j => ‖(col k) j‖ / w k)
    (x := fun k => w k * ‖toLp (annA k u)‖) (y := fun j => ‖toLp (annA j v)‖) (K := K)
    (fun k j => div_nonneg (norm_nonneg _) (w_pos hw k).le)
    (fun k => mul_nonneg (w_pos hw k).le (norm_nonneg _)) (fun j => norm_nonneg _) hK0
    (fun k => wrow_le hw hrow k L) (fun j => wcol_le hw hherm hcolg j L)
  have hLHS : ∑ k ∈ L, ∑ j ∈ L, (‖(col k) j‖ / w k)
      * ((w k * ‖toLp (annA k u)‖) * ‖toLp (annA j v)‖)
      = ∑ k ∈ L, ∑ j ∈ L, ‖(col k) j‖ * (‖toLp (annA k u)‖ * ‖toLp (annA j v)‖) := by
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
    have hwk : w k ≠ 0 := (w_pos hw k).ne'
    field_simp
  have hxsum : ∑ k ∈ L, (w k * ‖toLp (annA k u)‖) ^ 2 = Q := by
    have hid := sum_wsq_normSq_annA (w := w) (u := u) (L := L)
      (modes_left_subset_closure col u v)
    rw [hQdef, ← hid]
    exact Finset.sum_congr rfl fun k _ => by ring
  have hysum : ∑ j ∈ L, ‖toLp (annA j v)‖ ^ 2 = (n : ℝ) * ‖toLp v‖ ^ 2 :=
    sum_normSq_annA_of_sector hvsec (modes_right_subset_closure col u v)
  rw [hLHS, hxsum, hysum] at hschur
  have hsqrtv : Real.sqrt ((n : ℝ) * ‖toLp v‖ ^ 2) = Real.sqrt n * ‖toLp v‖ := by
    rw [Real.sqrt_mul (Nat.cast_nonneg n), Real.sqrt_sq (norm_nonneg _)]
  rw [hsqrtv] at hschur
  have hkey : ‖toLp v‖ ^ 2 ≤ K * (Real.sqrt Q * (Real.sqrt n * ‖toLp v‖)) :=
    le_trans hbound hschur
  have hsq : Real.sqrt Q ^ 2 = Q := Real.sq_sqrt hQ0
  have hsn : Real.sqrt n ^ 2 = (n : ℝ) := Real.sq_sqrt (Nat.cast_nonneg n)
  have hQs : 0 ≤ Real.sqrt Q := Real.sqrt_nonneg _
  have hns : 0 ≤ Real.sqrt n := Real.sqrt_nonneg _
  rcases eq_or_lt_of_le (norm_nonneg (toLp v)) with hz | hpos
  · rw [← hz]
    simpa using mul_nonneg (sq_nonneg K) (mul_nonneg (Nat.cast_nonneg n) hQ0)
  · have hle : ‖toLp v‖ ≤ K * (Real.sqrt Q * Real.sqrt n) := by
      nlinarith [hkey, hpos]
    have hRnn : 0 ≤ K * (Real.sqrt Q * Real.sqrt n) :=
      mul_nonneg hK0 (mul_nonneg hQs hns)
    calc ‖toLp v‖ ^ 2 ≤ (K * (Real.sqrt Q * Real.sqrt n)) ^ 2 := by nlinarith [hle, hpos]
      _ = K ^ 2 * ((n : ℝ) * Q) := by
          rw [mul_pow, mul_pow, hsq, hsn]; ring

/-! ## 5. The relative bound on the core -/

/-- **The weighted number bound.**  `‖dΓ(A)u‖ ≤ K‖σ u‖` on the finite-occupation core, with
`σ(α) = ∑_k w_k² α_k + 1`. -/
theorem normSq_dGamma_le_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K) (u : FockAlg) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ∑ α ∈ u.support, wSym w α ^ 2 * ‖u α‖ ^ 2 := by
  classical
  set D : Finset ℕ := u.support.image ndeg with hD
  have hsplit : dGamma col u = ∑ n ∈ D, dGamma col (sectorPart n u) := by
    conv_lhs => rw [← sum_sectorPart u]
    rw [map_sum]
  have hsec : ∀ n ∈ D, InSector n (dGamma col (sectorPart n u)) := fun n _ =>
    dGamma_inSector col (sectorPart_inSector n u)
  rw [hsplit, normSq_sum_of_sectors _ hsec]
  have hterm : ∀ n ∈ D, ‖toLp (dGamma col (sectorPart n u))‖ ^ 2
      ≤ K ^ 2 * ∑ α ∈ u.support.filter (fun α => ndeg α = n), wSym w α ^ 2 * ‖u α‖ ^ 2 := by
    intro n _
    set F : Finset Conf := u.support.filter (fun α => ndeg α = n) with hF
    have hsub : (sectorPart n u).support ⊆ F := by
      rw [sectorPart, Finsupp.support_filter]
    have h1 : ∑ α ∈ (sectorPart n u).support, wdeg w α * ‖(sectorPart n u) α‖ ^ 2
        = ∑ α ∈ F, wdeg w α * ‖u α‖ ^ 2 := by
      rw [Finset.sum_subset hsub (fun α _ hα => by
        rw [Finsupp.notMem_support_iff.mp hα]; simp)]
      refine Finset.sum_congr rfl fun α hα => ?_
      rw [sectorPart_apply, if_pos (Finset.mem_filter.mp hα).2]
    have hbase := normSq_dGamma_le_of_sector hw hherm hrow hcolg hK0
      (sectorPart_inSector n u)
    rw [h1] at hbase
    refine le_trans hbase ?_
    refine mul_le_mul_of_nonneg_left ?_ (sq_nonneg K)
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun α hα => ?_
    have hn : ndeg α = n := (Finset.mem_filter.mp hα).2
    have h2 : ((n : ℝ)) ≤ wdeg w α := by
      rw [← hn]; exact ndeg_le_wdeg hw α
    have h3 : (0:ℝ) ≤ wdeg w α := wdeg_nonneg α
    have h4 : (n : ℝ) * wdeg w α ≤ wSym w α ^ 2 := by
      have : wSym w α = wdeg w α + 1 := rfl
      nlinarith
    have h5 : (0:ℝ) ≤ ‖u α‖ ^ 2 := sq_nonneg _
    calc (n : ℝ) * (wdeg w α * ‖u α‖ ^ 2) = ((n : ℝ) * wdeg w α) * ‖u α‖ ^ 2 := by ring
      _ ≤ wSym w α ^ 2 * ‖u α‖ ^ 2 := mul_le_mul_of_nonneg_right h4 h5
  refine le_trans (Finset.sum_le_sum hterm) ?_
  rw [← Finset.mul_sum]
  refine mul_le_mul_of_nonneg_left (le_of_eq ?_) (sq_nonneg K)
  exact Finset.sum_fiberwise_of_maps_to (fun α hα => Finset.mem_image_of_mem ndeg hα) _

/-! ## 6. The commutator estimate -/

/-- **The commutator estimate.**  `|⟪u, i[dΓ(A), σ]u⟫| ≤ B⟪u, σu⟫` on the core: the part of
`⟪dΓ(A)u, σu⟫` that survives conjugation is
`∑_{k,j} conj(A_{kj})(w_j² − w_k²)⟪a_k u, a_j u⟫`. -/
theorem im_inner_dGamma_wgt_bound (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (u : FockAlg) :
    |(-2 : ℝ) * (inner ℂ (toLp (dGamma col u)) (toLp (wgt w u)) : ℂ).im|
      ≤ B * (inner ℂ (toLp u) (toLp (wgt w u)) : ℂ).re := by
  classical
  set N : FockAlg := wgt w u with hNdef
  set L : Finset ℕ := closureModes col u N with hLdef
  set z : ℂ := inner ℂ (toLp (dGamma col u)) (toLp N) with hzdef
  set f : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j)
    * inner ℂ (toLp (annA k u)) (toLp (wgt w (annA j u))) with hfdef
  set g : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j) * ((w j ^ 2 : ℝ) : ℂ)
    * inner ℂ (toLp (annA k u)) (toLp (annA j u)) with hgdef
  set p : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j) * ((w k ^ 2 : ℝ) : ℂ)
    * inner ℂ (toLp (annA k u)) (toLp (annA j u)) with hpdef
  have hexp : z = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
      * inner ℂ (toLp (annA k u)) (toLp (annA j N)) :=
    inner_dGamma_left col u N (modes_left_subset_closure col u N)
      (col_support_subset_closure col u N)
  have hterm : ∀ k j, (starRingEnd ℂ) ((col k) j)
      * (inner ℂ (toLp (annA k u)) (toLp (annA j N)) : ℂ) = f k j + g k j := by
    intro k j
    have hsplit : toLp (annA j N)
        = toLp (wgt w (annA j u)) + ((w j ^ 2 : ℝ) : ℂ) • toLp (annA j u) := by
      rw [hNdef, annA_wgt j u, ← toLpL_apply, map_add, map_smul, toLpL_apply, toLpL_apply]
    rw [hsplit, inner_add_right, inner_smul_right, hfdef, hgdef]
    ring
  set P : ℂ := ∑ k ∈ L, ∑ j ∈ L, f k j with hPdef
  set Q : ℂ := ∑ k ∈ L, ∑ j ∈ L, g k j with hQdef
  set R : ℂ := ∑ k ∈ L, ∑ j ∈ L, p k j with hRdef
  have hzPQ : z = P + Q := by
    rw [hexp, Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hterm k j)),
      hPdef, hQdef]
    simp only [Finset.sum_add_distrib]
  have hconjf : ∀ k j, (starRingEnd ℂ) (f k j) = f j k := by
    intro k j
    have h1 : (starRingEnd ℂ) ((starRingEnd ℂ) ((col k) j)) = (col k) j := by simp
    have h2 : (starRingEnd ℂ) (inner ℂ (toLp (annA k u)) (toLp (wgt w (annA j u))) : ℂ)
        = inner ℂ (toLp (wgt w (annA j u))) (toLp (annA k u)) := inner_conj_symm _ _
    have h3 : (inner ℂ (toLp (wgt w (annA j u))) (toLp (annA k u)) : ℂ)
        = inner ℂ (toLp (annA j u)) (toLp (wgt w (annA k u))) := inner_wgt_symm _ _
    have h4 : (starRingEnd ℂ) ((col j) k) = (col k) j := by rw [hherm j k]; simp
    simp only [hfdef]
    rw [map_mul, h1, h2, h3, h4]
  have hconjg : ∀ k j, (starRingEnd ℂ) (g k j) = p j k := by
    intro k j
    have h1 : (starRingEnd ℂ) ((starRingEnd ℂ) ((col k) j)) = (col k) j := by simp
    have h2 : (starRingEnd ℂ) (inner ℂ (toLp (annA k u)) (toLp (annA j u)) : ℂ)
        = inner ℂ (toLp (annA j u)) (toLp (annA k u)) := inner_conj_symm _ _
    have h4 : (starRingEnd ℂ) ((col j) k) = (col k) j := by rw [hherm j k]; simp
    simp only [hgdef, hpdef]
    rw [map_mul, map_mul, h1, Complex.conj_ofReal, h2, h4]
  have hconjP : (starRingEnd ℂ) P = P := by
    simp only [hPdef, map_sum]
    rw [Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hconjf k j))]
    exact Finset.sum_comm
  have hconjQ : (starRingEnd ℂ) Q = R := by
    simp only [hQdef, hRdef, map_sum]
    rw [Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hconjg k j))]
    exact Finset.sum_comm
  have hdiff : z - (starRingEnd ℂ) z = Q - R := by
    rw [hzPQ, map_add, hconjP, hconjQ]
    ring
  have hQR : Q - R = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
      * ((w j ^ 2 - w k ^ 2 : ℝ) : ℂ) * inner ℂ (toLp (annA k u)) (toLp (annA j u)) := by
    rw [hQdef, hRdef, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [hgdef, hpdef]
    push_cast
    ring
  -- the Schur estimate of the surviving term
  set x : ℕ → ℝ := fun k => ‖toLp (annA k u)‖ with hxdef
  have hnorm : ‖Q - R‖ ≤ ∑ k ∈ L, ∑ j ∈ L,
      (‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j)) * ((w k * x k) * (w j * x j)) := by
    rw [hQR]
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
    have hwk : w k ≠ 0 := (w_pos hw k).ne'
    have hwj : w j ≠ 0 := (w_pos hw j).ne'
    have hstep : ‖(starRingEnd ℂ) ((col k) j) * ((w j ^ 2 - w k ^ 2 : ℝ) : ℂ)
        * inner ℂ (toLp (annA k u)) (toLp (annA j u))‖
        ≤ ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| * (x k * x j) := by
      rw [norm_mul, norm_mul, RCLike.norm_conj, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _)
        (mul_nonneg (norm_nonneg _) (abs_nonneg _))
    refine le_trans hstep (le_of_eq ?_)
    field_simp
  have hB0 : 0 ≤ B := wcomm_nonneg hw hBg
  have hschur := schur_test (L := L)
    (m := fun k j => ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j))
    (x := fun k => w k * x k) (y := fun j => w j * x j) (K := B)
    (fun k j => by
      have : 0 < w k * w j := mul_pos (w_pos hw k) (w_pos hw j)
      positivity)
    (fun k => mul_nonneg (w_pos hw k).le (norm_nonneg _))
    (fun j => mul_nonneg (w_pos hw j).le (norm_nonneg _)) hB0
    (fun k => wcomm_row_le hw hBg k L) (fun j => wcomm_col_le hw hherm hBg j L)
  set S : ℝ := ∑ k ∈ L, (w k * x k) ^ 2 with hSdef
  have hS0 : 0 ≤ S := Finset.sum_nonneg fun k _ => sq_nonneg _
  have hsqrtS : Real.sqrt S * Real.sqrt S = S := Real.mul_self_sqrt hS0
  rw [hsqrtS] at hschur
  have hSval : S = ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 := by
    have hid := sum_wsq_normSq_annA (w := w) (u := u) (L := L)
      (modes_left_subset_closure col u N)
    rw [hSdef, ← hid]
    exact Finset.sum_congr rfl fun k _ => by rw [hxdef]; ring
  have hSle : S ≤ (inner ℂ (toLp u) (toLp N) : ℂ).re := by
    rw [hSval, hNdef, re_inner_wgt]
    refine Finset.sum_le_sum fun α _ => ?_
    have : wdeg w α ≤ wSym w α := by simp only [wSym]; linarith
    exact mul_le_mul_of_nonneg_right this (sq_nonneg _)
  have habs : |(-2 : ℝ) * z.im| = ‖z - (starRingEnd ℂ) z‖ := by
    rw [Complex.sub_conj, norm_mul, Complex.norm_I, mul_one, Complex.norm_real,
      Real.norm_eq_abs, abs_mul, abs_mul]
    norm_num
  calc |(-2 : ℝ) * z.im| = ‖Q - R‖ := by rw [habs, hdiff]
    _ ≤ ∑ k ∈ L, ∑ j ∈ L, (‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j))
          * ((w k * x k) * (w j * x j)) := hnorm
    _ ≤ B * S := hschur
    _ ≤ B * (inner ℂ (toLp u) (toLp N) : ℂ).re := mul_le_mul_of_nonneg_left hSle hB0

/-! ## 7. Essential self-adjointness on the finite-occupation core -/

theorem diagMax_wSym_eq (x : lpFiniteModes Conf) :
    (diagMax (wSym w) (inclC (wSym w) x) : Fock) = toLp (wgt w (fockEquiv.symm x)) := by
  refine lp.ext (funext fun α => ?_)
  rw [diagMax_coe]
  have hx : ((x : Fock) : Conf → ℂ) α = (fockEquiv.symm x) α := by
    rw [coe_fockEquiv_symm x]
    rfl
  rw [inclC_coe, hx]
  rfl

theorem normSq_toLp_wgt (u : FockAlg) :
    ‖toLp (wgt w u)‖ ^ 2 = ∑ α ∈ u.support, wSym w α ^ 2 * ‖u α‖ ^ 2 := by
  rw [normSq_toLp_of_subset (support_wgt_subset u)]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [wgt_apply, norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs]

/-- The relative bound against the weighted comparison operator, on the core. -/
theorem dGammaOp_coreRelBound_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K) :
    CoreRelBound (wSym w) (dGammaOp col) K := by
  intro x
  set u : FockAlg := fockEquiv.symm x with hu
  rw [coe_dGammaOp col x, diagMax_wSym_eq x]
  have hsq : ‖toLp (dGamma col u)‖ ^ 2 ≤ (K * ‖toLp (wgt w u)‖) ^ 2 := by
    rw [mul_pow, normSq_toLp_wgt]
    exact normSq_dGamma_le_w hw hherm hrow hcolg hK0 u
  have hR : 0 ≤ K * ‖toLp (wgt w u)‖ := mul_nonneg hK0 (norm_nonneg _)
  have hL : 0 ≤ ‖toLp (dGamma col u)‖ := norm_nonneg _
  nlinarith [hsq, hR, hL]

/-- The commutator bound on the core, in the form the Faris–Lavine instrument asks for. -/
theorem dGammaOp_commForm_bound_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (x : lpFiniteModes Conf) :
    |(-2 : ℝ) * (inner ℂ (dGammaOp col x)
        ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).im|
      ≤ B * (inner ℂ ((x : Fock)) ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).re := by
  rw [coe_dGammaOp col x, diagMax_wSym_eq x, coe_fockEquiv_symm x]
  exact im_inner_dGamma_wgt_bound hw hherm hBg _

/-- **The headline.**  The second quantization of a Hermitian, column-finite one-particle
matrix satisfying the Schur gates *weighted by the one-particle symbol* `w` — the row gate
`∑_j |A_{kj}| ≤ K w_k`, the column gate `∑_k |A_{jk}|/w_k ≤ K` and the commutator gate
`∑_j |A_{kj}||w_j² − w_k²|/(w_k w_j) ≤ B` — is essentially self-adjoint on the
finite-occupation core of the Fock space.  The one-particle operator need not be
bounded. -/
theorem dGamma_essentiallySelfAdjointOn_core_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    (hBg : WCommBound w col B) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp col) :=
  essentiallySelfAdjointOn_finiteModes_of_core_bounds (wSym w) (fun α => wSym_nonneg α)
    (dGammaOp col) K B (wcomm_nonneg hw hBg) (fun u v => dGammaOp_symmetricOn hherm u v)
    (dGammaOp_coreRelBound_w hw hherm hrow hcolg hK0) (dGammaOp_commForm_bound_w hw hherm hBg)

/-- **The dynamics.**  The unique self-adjoint realization of `dΓ(A)` generates a complete
unitary group. -/
theorem dGamma_stone_flow_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    (hBg : WCommBound w col B) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp col) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ finiteOccupation_dense (dGammaOp_symmetricOn hherm)
    (dGamma_essentiallySelfAdjointOn_core_w hw hherm hrow hcolg hK0 hBg)

/-! ## 8. Non-vacuity: an unbounded one-particle operator -/

/-- `√a ≤ a` for `a ≥ 1`. -/
theorem sqrt_le_of_one_le {a : ℝ} (h : 1 ≤ a) : Real.sqrt a ≤ a := by
  have h0 : (0:ℝ) ≤ a := le_trans zero_le_one h
  nlinarith [Real.sq_sqrt h0, Real.sqrt_nonneg a, sq_nonneg (Real.sqrt a - 1)]

/-- The one-particle matrix `A_{k,k+1} = A_{k+1,k} = √(k+1)`, presented by its columns: the
position operator of a harmonic oscillator in the occupation basis.  It is Hermitian,
column-finite and **unbounded**. -/
def oscCol (k : ℕ) : ℕ →₀ ℂ :=
  if k = 0 then Finsupp.single 1 ((Real.sqrt 1 : ℝ) : ℂ)
  else Finsupp.single (k + 1) ((Real.sqrt ((k : ℝ) + 1) : ℝ) : ℂ)
      + Finsupp.single (k - 1) ((Real.sqrt (k : ℝ) : ℝ) : ℂ)

/-- The one-particle symbol `w_k = k + 1`. -/
def oscW (k : ℕ) : ℝ := (k : ℝ) + 1

theorem oscW_ge_one (k : ℕ) : 1 ≤ oscW k := by
  have : (0:ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  simp only [oscW]; linarith

theorem oscW_pos (k : ℕ) : 0 < oscW k := lt_of_lt_of_le zero_lt_one (oscW_ge_one k)

theorem oscCol_apply (k j : ℕ) : (oscCol k) j =
    if j = k + 1 then ((Real.sqrt ((k : ℝ) + 1) : ℝ) : ℂ)
    else if k = j + 1 then ((Real.sqrt (k : ℝ) : ℝ) : ℂ) else 0 := by
  classical
  rcases Nat.eq_zero_or_pos k with hk | hk
  · subst hk
    rw [oscCol, if_pos rfl, Finsupp.single_apply]
    by_cases h : j = 0 + 1
    · rw [if_pos (by omega : (1:ℕ) = j), if_pos h]
      norm_num
    · rw [if_neg (by omega : ¬((1:ℕ) = j)), if_neg h, if_neg (by omega)]
  · rw [oscCol, if_neg (by omega), Finsupp.add_apply, Finsupp.single_apply,
      Finsupp.single_apply]
    by_cases h1 : j = k + 1
    · rw [if_pos (by omega : k + 1 = j), if_neg (by omega : ¬(k - 1 = j)), if_pos h1]
      simp
    · by_cases h2 : k = j + 1
      · rw [if_neg (by omega : ¬(k + 1 = j)), if_pos (by omega : k - 1 = j), if_neg h1,
          if_pos h2]
        simp
      · rw [if_neg (by omega : ¬(k + 1 = j)), if_neg (by omega : ¬(k - 1 = j)), if_neg h1,
          if_neg h2]
        simp

theorem norm_oscCol_apply (k j : ℕ) : ‖(oscCol k) j‖ =
    if j = k + 1 then Real.sqrt ((k : ℝ) + 1)
    else if k = j + 1 then Real.sqrt (k : ℝ) else 0 := by
  rw [oscCol_apply]
  by_cases h1 : j = k + 1
  · rw [if_pos h1, if_pos h1, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (Real.sqrt_nonneg _)]
  · by_cases h2 : k = j + 1
    · rw [if_neg h1, if_pos h2, if_neg h1, if_pos h2, Complex.norm_real, Real.norm_eq_abs,
        abs_of_nonneg (Real.sqrt_nonneg _)]
    · rw [if_neg h1, if_neg h2, if_neg h1, if_neg h2, norm_zero]

theorem isHermCol_oscCol : IsHermCol oscCol := by
  intro j k
  rw [oscCol_apply, oscCol_apply]
  by_cases h1 : k = j + 1
  · have h2 : ¬(j = k + 1) := by omega
    rw [if_pos h1, if_neg h2, if_pos h1, Complex.conj_ofReal]
    have : ((k : ℝ)) = (j : ℝ) + 1 := by rw [h1]; push_cast; ring
    rw [this]
  · by_cases h2 : j = k + 1
    · rw [if_neg h1, if_pos h2, if_pos h2, Complex.conj_ofReal]
      have : ((j : ℝ)) = (k : ℝ) + 1 := by rw [h2]; push_cast; ring
      rw [this]
    · rw [if_neg h1, if_neg h2, if_neg h1, if_neg h2]
      simp

theorem support_oscCol_subset (k : ℕ) : (oscCol k).support ⊆ {k + 1, k - 1} := by
  classical
  intro j hj
  have hne : (oscCol k) j ≠ 0 := Finsupp.mem_support_iff.mp hj
  rw [oscCol_apply] at hne
  by_cases h1 : j = k + 1
  · simp [h1]
  · by_cases h2 : k = j + 1
    · have : j = k - 1 := by omega
      simp [this]
    · rw [if_neg h1, if_neg h2] at hne
      exact absurd rfl hne

/-- A sum over a set of at most two modes, from a uniform bound on the terms. -/
theorem sum_pair_le {f : ℕ → ℝ} {S : Finset ℕ} {a b : ℕ} {C : ℝ} (hS : S ⊆ {a, b})
    (hf : ∀ j, 0 ≤ f j) (hC : ∀ j, f j ≤ C) (hC0 : 0 ≤ C) : ∑ j ∈ S, f j ≤ 2 * C := by
  classical
  have hcard : ((({a, b} : Finset ℕ)).card : ℝ) ≤ 2 := by
    have : (({a, b} : Finset ℕ)).card ≤ 2 := (Finset.card_insert_le _ _).trans (by simp)
    exact_mod_cast this
  calc ∑ j ∈ S, f j ≤ ∑ j ∈ ({a, b} : Finset ℕ), f j :=
        Finset.sum_le_sum_of_subset_of_nonneg hS fun j _ _ => hf j
    _ ≤ ∑ _j ∈ ({a, b} : Finset ℕ), C := Finset.sum_le_sum fun j _ => hC j
    _ ≤ 2 * C := by
        simp only [Finset.sum_const, nsmul_eq_mul]
        nlinarith [hC0, hcard]

/-- Every entry of a column is bounded by the symbol at its **row** index. -/
theorem norm_oscCol_le (k j : ℕ) : ‖(oscCol k) j‖ ≤ oscW k := by
  rw [norm_oscCol_apply]
  have hk0 : (0:ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  by_cases h1 : j = k + 1
  · rw [if_pos h1]
    have := sqrt_le_of_one_le (a := (k : ℝ) + 1) (by linarith)
    simpa [oscW] using this
  · by_cases h2 : k = j + 1
    · rw [if_neg h1, if_pos h2]
      have hk1 : (1:ℝ) ≤ (k : ℝ) := by
        have : (1:ℕ) ≤ k := by omega
        exact_mod_cast this
      have := sqrt_le_of_one_le hk1
      simp only [oscW]; linarith
    · rw [if_neg h1, if_neg h2]
      simp only [oscW]; linarith

/-- Every entry of a column is bounded by the symbol at its **column** index. -/
theorem norm_oscCol_le_col (j k : ℕ) : ‖(oscCol j) k‖ ≤ oscW k := by
  rw [norm_oscCol_apply]
  have hj0 : (0:ℝ) ≤ (j : ℝ) := Nat.cast_nonneg j
  have hk0 : (0:ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  by_cases h1 : k = j + 1
  · rw [if_pos h1]
    have hkj : (k : ℝ) = (j : ℝ) + 1 := by rw [h1]; push_cast; ring
    have := sqrt_le_of_one_le (a := (j : ℝ) + 1) (by linarith)
    simp only [oscW]; linarith
  · by_cases h2 : j = k + 1
    · rw [if_neg h1, if_pos h2]
      have hjk : (j : ℝ) = (k : ℝ) + 1 := by rw [h2]; push_cast; ring
      have := sqrt_le_of_one_le (a := (j : ℝ)) (by rw [hjk]; linarith)
      simp only [oscW]; linarith
    · rw [if_neg h1, if_neg h2]
      simp only [oscW]; linarith

theorem wRow_oscCol : WRowBound oscW oscCol 2 := by
  intro k
  exact sum_pair_le (support_oscCol_subset k) (fun j => norm_nonneg _)
    (fun j => norm_oscCol_le k j) (le_of_lt (oscW_pos k))

theorem wCol_oscCol : WColBound oscW oscCol 2 := by
  intro j
  have h := sum_pair_le (f := fun k => ‖(oscCol j) k‖ / oscW k) (C := 1)
    (support_oscCol_subset j) (fun k => div_nonneg (norm_nonneg _) (oscW_pos k).le)
    (fun k => by
      rw [div_le_one (oscW_pos k)]
      exact norm_oscCol_le_col j k) zero_le_one
  simpa using h

/-- The commutator terms of the oscillator matrix are bounded by `2`. -/
theorem oscComm_term_le (k j : ℕ) :
    ‖(oscCol k) j‖ * |oscW j ^ 2 - oscW k ^ 2| / (oscW k * oscW j) ≤ 2 := by
  have hk0 : (0:ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  have hj0 : (0:ℝ) ≤ (j : ℝ) := Nat.cast_nonneg j
  have hwk : 0 < oscW k := oscW_pos k
  have hwj : 0 < oscW j := oscW_pos j
  rw [div_le_iff₀ (mul_pos hwk hwj), norm_oscCol_apply]
  by_cases h1 : j = k + 1
  · rw [if_pos h1]
    have hj : oscW j = (k : ℝ) + 2 := by
      simp only [oscW, h1]; push_cast; ring
    have hkk : oscW k = (k : ℝ) + 1 := rfl
    have habs : |oscW j ^ 2 - oscW k ^ 2| = 2 * (k : ℝ) + 3 := by
      rw [hj, hkk, abs_of_nonneg (by nlinarith)]
      ring
    rw [habs, hj, hkk]
    have hs : Real.sqrt ((k : ℝ) + 1) ≤ (k : ℝ) + 1 :=
      sqrt_le_of_one_le (by linarith)
    have hs0 : 0 ≤ Real.sqrt ((k : ℝ) + 1) := Real.sqrt_nonneg _
    nlinarith [hs, hs0]
  · by_cases h2 : k = j + 1
    · rw [if_neg h1, if_pos h2]
      have hk1 : (1:ℝ) ≤ (k : ℝ) := by
        have : (1:ℕ) ≤ k := by omega
        exact_mod_cast this
      have hjk : (j : ℝ) = (k : ℝ) - 1 := by
        have : (k : ℝ) = (j : ℝ) + 1 := by rw [h2]; push_cast; ring
        linarith
      have hj : oscW j = (k : ℝ) := by simp only [oscW, hjk]; ring
      have hkk : oscW k = (k : ℝ) + 1 := rfl
      have habs : |oscW j ^ 2 - oscW k ^ 2| = 2 * (k : ℝ) + 1 := by
        rw [hj, hkk, abs_of_nonpos (by nlinarith)]
        ring
      rw [habs, hj, hkk]
      have hs : Real.sqrt (k : ℝ) ≤ (k : ℝ) := sqrt_le_of_one_le hk1
      have hs0 : 0 ≤ Real.sqrt (k : ℝ) := Real.sqrt_nonneg _
      nlinarith [hs, hs0]
    · rw [if_neg h1, if_neg h2]
      have : 0 < oscW k * oscW j := mul_pos hwk hwj
      nlinarith

theorem wComm_oscCol : WCommBound oscW oscCol 4 := by
  intro k
  have h := sum_pair_le
    (f := fun j => ‖(oscCol k) j‖ * |oscW j ^ 2 - oscW k ^ 2| / (oscW k * oscW j)) (C := 2)
    (support_oscCol_subset k)
    (fun j => by
      have : 0 < oscW k * oscW j := mul_pos (oscW_pos k) (oscW_pos j)
      positivity)
    (fun j => oscComm_term_le k j) (by norm_num)
  exact le_trans h (by norm_num)

/-- The entries of the oscillator matrix are **unbounded**: the one-particle operator it
defines is not bounded, so the unweighted Schur gate of `ChapterFockSchurEsa` cannot
apply. -/
theorem oscCol_entries_unbounded (C : ℝ) : ∃ k : ℕ, C ≤ ‖(oscCol k) (k + 1)‖ := by
  obtain ⟨n, hn⟩ := exists_nat_gt (C ^ 2)
  refine ⟨n, ?_⟩
  rw [norm_oscCol_apply, if_pos rfl]
  by_cases hC : C ≤ 0
  · exact le_trans hC (Real.sqrt_nonneg _)
  · have hC : 0 < C := lt_of_not_ge hC
    have h1 : C ^ 2 < (n : ℝ) + 1 := by linarith
    have h2 : Real.sqrt (C ^ 2) < Real.sqrt ((n : ℝ) + 1) := by
      exact Real.sqrt_lt_sqrt (sq_nonneg C) h1
    rw [Real.sqrt_sq hC.le] at h2
    exact h2.le

/-- The oscillator matrix satisfies **no** unweighted Schur bound. -/
theorem oscCol_not_schurBound (K : ℝ) : ¬ SchurBound oscCol K := by
  classical
  intro hK
  obtain ⟨k, hk⟩ := oscCol_entries_unbounded (K + 1)
  have hmem : k + 1 ∈ (oscCol k).support := by
    refine Finsupp.mem_support_iff.mpr fun hc => ?_
    rw [show ‖(oscCol k) (k+1)‖ = 0 from by rw [hc]; simp] at hk
    have h0 : (0:ℝ) ≤ K := by
      have := hK k
      have hnn : (0:ℝ) ≤ ∑ j ∈ (oscCol k).support, ‖(oscCol k) j‖ :=
        Finset.sum_nonneg fun j _ => norm_nonneg _
      linarith
    linarith
  have hsingle : ‖(oscCol k) (k + 1)‖ ≤ ∑ j ∈ (oscCol k).support, ‖(oscCol k) j‖ :=
    Finset.single_le_sum (f := fun j => ‖(oscCol k) j‖) (fun j _ => norm_nonneg _) hmem
  have := hK k
  linarith

/-- **The second quantization of an unbounded one-particle operator is essentially
self-adjoint on the finite-occupation core.** -/
theorem osc_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp oscCol) :=
  dGamma_essentiallySelfAdjointOn_core_w (w := oscW) (K := 2) (B := 4) oscW_ge_one
    isHermCol_oscCol wRow_oscCol wCol_oscCol (by norm_num) wComm_oscCol

/-- **Its unitary group.** -/
theorem osc_stone_flow :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp oscCol) T.op ∧ IsStoneFlow T U :=
  dGamma_stone_flow_w (w := oscW) (K := 2) (B := 4) oscW_ge_one isHermCol_oscCol
    wRow_oscCol wCol_oscCol (by norm_num) wComm_oscCol

end

end BookProof.FockWeightedSchur
