import Mathlib
import BookProof.ChapterNavierStokesShiftHamiltonian

/-!
# The Navier–Stokes Hamiltonian of a many-mode field, and its Faris–Lavine bounds

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for the Navier–Stokes fiber Hamiltonian of **one** degree of
freedom.  This module carries out the second quantization: the field has `d`
modes, each with its own fiber coordinate `uᵢ`, its own momentum
`πᵢ = -i ∂/∂uᵢ` and its own linear advection field `Vᵢ(u) = κᵢ uᵢ`, and the
Hamiltonian and the comparison operator are the sums over the modes

`Ĥ = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)`,  `N̂ = ∑ᵢ (πᵢ² + Vᵢ²) + I`.

In the Hermite (occupation-number) basis of the modes, the Hilbert space is
`ℓ²(ℕᵈ)` — the Fock space of the `d`-mode boson field — the states are labelled
by occupation configurations `α : Fin d → ℕ`, the comparison operator is
multiplication by the total energy

`Σ(α) = ∑ᵢ κᵢ(2αᵢ + 1) + 1`  (`fockSym`),

and the Hamiltonian is the sum over the modes of the pair
creation/annihilation ("Bogoliubov") terms `(iκᵢ/2)(aᵢ†² − aᵢ²)`, each of which
hops `α ↦ α ± 2eᵢ`.

Each mode contributes an abstract shift Hamiltonian in the sense of
`BookProof.ChapterNavierStokesShiftHamiltonian` — with the **total** symbol `Σ`
as its comparison symbol — so the one-mode analysis applies to each summand, and
the many-mode inequalities follow by finitely many applications of
`(∑ᵢ aᵢ)² ≤ d ∑ᵢ aᵢ²`.

## What is proved

* `fockH_symmetricOn` — `Ĥ` is symmetric on the maximal domain of `N̂`;
* `fockH_relative_bound` — `‖Ĥx‖² ≤ (d²/2)‖N̂x‖² + 2d(∑ᵢκᵢ²)‖x‖²`;
* `fockH_commForm_bound` — `|⟪x, i[Ĥ, N̂]x⟫| ≤ (∑ᵢ(2κᵢ + 4κᵢ²)) ⟪x, N̂x⟫`;
* `fockH_essentiallySelfAdjointOn_core` — hence `Ĥ` is essentially self-adjoint
  on the finite-configuration core of the many-mode Fock space.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace FockManyMode

open LpNat FarisLavine IkebeKato ShiftHamiltonian

/-- An occupation-number configuration of the `d` field modes: `α i` quanta in
the Hermite level of the mode `i`.  `ℓ²(Occ d)` is the Fock space of the `d`-mode
boson field. -/
abbrev Occ (d : ℕ) := Fin d → ℕ

variable {d : ℕ} {κ : Fin d → ℝ}

/-- **The symbol of the many-mode comparison operator** `N̂ = ∑ᵢ(πᵢ² + Vᵢ²) + I`:
the total energy `Σ(α) = ∑ᵢ κᵢ(2αᵢ + 1) + 1`. -/
def fockSym (κ : Fin d → ℝ) : Occ d → ℝ := fun α => (∑ i, κ i * (2 * (α i : ℝ) + 1)) + 1

theorem fockSym_ge_one (hκ : ∀ i, 0 ≤ κ i) (α : Occ d) : 1 ≤ fockSym κ α := by
  have h : (0 : ℝ) ≤ ∑ i, κ i * (2 * (α i : ℝ) + 1) :=
    Finset.sum_nonneg fun i _ => mul_nonneg (hκ i) (by positivity)
  simp only [fockSym]
  linarith

theorem fockSym_nonneg (hκ : ∀ i, 0 ≤ κ i) (α : Occ d) : 0 ≤ fockSym κ α :=
  le_trans zero_le_one (fockSym_ge_one hκ α)

/-- The single term of the total energy is dominated by the total energy. -/
theorem single_le_fockSym (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) (α : Occ d) :
    κ i * (2 * (α i : ℝ) + 1) ≤ fockSym κ α := by
  have h : κ i * (2 * (α i : ℝ) + 1) ≤ ∑ j, κ j * (2 * (α j : ℝ) + 1) :=
    Finset.single_le_sum (f := fun j => κ j * (2 * (α j : ℝ) + 1))
      (fun j _ => mul_nonneg (hκ j) (by positivity)) (Finset.mem_univ i)
  simp only [fockSym]
  linarith

/-! ## The mode-wise shift data -/

/-- The creation of two quanta in the mode `i`: `α ↦ α + 2eᵢ`. -/
def modeShift (i : Fin d) : Occ d → Occ d := fun α => Function.update α i (α i + 2)

@[simp] theorem modeShift_self (i : Fin d) (α : Occ d) : modeShift i α i = α i + 2 := by
  simp [modeShift]

theorem modeShift_injective (i : Fin d) : Function.Injective (modeShift i : Occ d → Occ d) := by
  intro α β h
  funext j
  by_cases hj : j = i
  · subst hj
    have hji := congrFun h j
    simp only [modeShift, Function.update_self] at hji
    omega
  · have hji := congrFun h j
    simpa [modeShift, hj] using hji

/-- The hopping amplitude of the mode `i`: `wᵢ(α) = (κᵢ/2)√((αᵢ+1)(αᵢ+2))`. -/
noncomputable def modeAmp (κ : Fin d → ℝ) (i : Fin d) : Occ d → ℝ :=
  fun α => (κ i / 2) * Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2))

theorem modeAmp_nonneg (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) (α : Occ d) : 0 ≤ modeAmp κ i α := by
  have h : (0 : ℝ) ≤ Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2)) := Real.sqrt_nonneg _
  have hi := hκ i
  simp only [modeAmp]
  positivity

theorem modeAmp_mono (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) (α : Occ d) :
    modeAmp κ i α ≤ modeAmp κ i (modeShift i α) := by
  have hmono : Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2))
      ≤ Real.sqrt ((((α i : ℝ) + 2) + 1) * (((α i : ℝ) + 2) + 2)) := by
    refine Real.sqrt_le_sqrt ?_
    nlinarith [Nat.cast_nonneg (α := ℝ) (α i)]
  simp only [modeAmp, modeShift_self]
  push_cast
  nlinarith [hmono, Real.sqrt_nonneg (((α i : ℝ) + 1) * ((α i : ℝ) + 2)), hκ i]

/-- **The amplitude is dominated by the total energy**: `wᵢ ≤ ¼Σ + κᵢ/2`. -/
theorem modeAmp_le (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) (α : Occ d) :
    modeAmp κ i α ≤ (1 / 4) * fockSym κ α + κ i / 2 := by
  have hs : Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2)) ≤ (α i : ℝ) + 3 / 2 := by
    have h1 : ((α i : ℝ) + 1) * ((α i : ℝ) + 2) ≤ ((α i : ℝ) + 3 / 2) ^ 2 := by nlinarith
    calc Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2))
        ≤ Real.sqrt (((α i : ℝ) + 3 / 2) ^ 2) := Real.sqrt_le_sqrt h1
      _ = (α i : ℝ) + 3 / 2 := by
          rw [Real.sqrt_sq (by positivity)]
  have hmul : (κ i / 2) * Real.sqrt (((α i : ℝ) + 1) * ((α i : ℝ) + 2))
      ≤ (κ i / 2) * ((α i : ℝ) + 3 / 2) :=
    mul_le_mul_of_nonneg_left hs (by linarith [hκ i])
  have hsym := single_le_fockSym hκ i α
  simp only [modeAmp]
  linarith

/-- The total energy increases by `4κᵢ` when two quanta are created in the mode
`i`. -/
theorem fockSym_step (i : Fin d) (α : Occ d) :
    fockSym κ (modeShift i α) = fockSym κ α + 4 * κ i := by
  have h : ∀ j : Fin d, κ j * (2 * ((modeShift i α) j : ℝ) + 1)
      = κ j * (2 * (α j : ℝ) + 1) + (if j = i then 4 * κ i else 0) := by
    intro j
    by_cases hj : j = i
    · subst hj
      simp only [modeShift_self, if_pos]
      push_cast
      ring
    · simp only [modeShift, Function.update_of_ne hj, if_neg hj]
      ring
  simp only [fockSym]
  rw [Finset.sum_congr rfl (fun j _ => h j), Finset.sum_add_distrib,
    Finset.sum_ite_eq' Finset.univ i (fun _ => 4 * κ i)]
  simp only [Finset.mem_univ, if_pos]
  ring

/-- **The shift data of the mode `i`**: the hopping `α ↦ α + 2eᵢ` with amplitude
`wᵢ`, compared with the *total* energy `Σ`. -/
noncomputable def modeData (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) : ShiftData (Occ d) where
  sym := fockSym κ
  shift := modeShift i
  amp := modeAmp κ i
  K := κ i / 2
  step := 4 * κ i
  shift_injective := modeShift_injective i
  amp_nonneg := modeAmp_nonneg hκ i
  amp_mono := modeAmp_mono hκ i
  K_nonneg := by linarith [hκ i]
  step_nonneg := by linarith [hκ i]
  sym_ge_one := fockSym_ge_one hκ
  amp_le := modeAmp_le hκ i
  sym_step := fockSym_step i

@[simp] theorem modeData_sym (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (modeData hκ i).sym = fockSym κ := rfl

/-! ## The many-mode Hamiltonian -/

/-- **The many-mode Navier–Stokes Hamiltonian** `Ĥ = ∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)`, on the
maximal domain of the comparison operator `N̂ = ∑ᵢ(πᵢ² + Vᵢ²) + I`. -/
noncomputable def fockH (hκ : ∀ i, 0 ≤ κ i) : maxDom (fockSym κ) →ₗ[ℂ] L2I (Occ d) :=
  ∑ i, ShiftData.shiftH (modeData hκ i)

theorem fockH_apply (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    (fockH hκ x : L2I (Occ d)) = ∑ i, (ShiftData.shiftH (modeData hκ i) x : L2I (Occ d)) := by
  rw [fockH]
  exact LinearMap.sum_apply _ _ _

/-- **The many-mode Hamiltonian is symmetric** on the maximal domain of `N̂`. -/
theorem fockH_symmetricOn (hκ : ∀ i, 0 ≤ κ i) :
    SymmetricOn (maxDom (fockSym κ)) (fockH hκ) := by
  intro x y
  rw [fockH_apply, sum_inner]
  have h : ∀ i : Fin d,
      (inner ℂ (ShiftData.shiftH (modeData hκ i) x : L2I (Occ d)) (y : L2I (Occ d)) : ℂ)
        = inner ℂ (x : L2I (Occ d)) (ShiftData.shiftH (modeData hκ i) y : L2I (Occ d)) :=
    fun i => ShiftData.shiftH_symmetricOn (modeData hκ i) x y
  rw [Finset.sum_congr rfl (fun i _ => h i), ← inner_sum, ← fockH_apply]

/-! ## The first Faris–Lavine inequality -/

/-- **The relative bound for the many-mode Hamiltonian**:
`‖Ĥx‖² ≤ (d²/2)‖N̂x‖² + 2d(∑ᵢκᵢ²)‖x‖²`. -/
theorem fockH_relative_bound (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    ‖(fockH hκ x : L2I (Occ d))‖ ^ 2
      ≤ ((d : ℝ) ^ 2 / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
        + (2 * d * ∑ i, κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by
  have hmode : ∀ i : Fin d,
      ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖ ^ 2
        ≤ (1 / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
          + (2 * κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by
    intro i
    have h := ShiftData.shiftH_relative_bound (modeData hκ i) x
    have hK : 8 * ((modeData hκ i).K) ^ 2 = 2 * κ i ^ 2 := by
      simp only [modeData]
      ring
    rw [hK] at h
    exact h
  have htri : ‖(fockH hκ x : L2I (Occ d))‖
      ≤ ∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖ := by
    rw [fockH_apply]
    exact norm_sum_le _ _
  have hsq : ‖(fockH hκ x : L2I (Occ d))‖ ^ 2
      ≤ (∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖) ^ 2 := by
    have h0 : (0 : ℝ) ≤ ‖(fockH hκ x : L2I (Occ d))‖ := norm_nonneg _
    nlinarith [htri, h0]
  have hcs : (∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖) ^ 2
      ≤ (d : ℝ) * ∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖ ^ 2 := by
    have h := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin d)))
      (f := fun i => ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖)
    simpa using h
  have hsum : (∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖ ^ 2)
      ≤ ((d : ℝ) / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
        + (2 * ∑ i, κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by
    have h := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin d))) => hmode i)
    rw [Finset.sum_add_distrib, ← Finset.sum_mul, ← Finset.sum_mul] at h
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at h
    calc (∑ i, ‖(ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))‖ ^ 2)
        ≤ ((d : ℝ) * (1 / 2)) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
            + (∑ i, 2 * κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := h
      _ = ((d : ℝ) / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
            + (2 * ∑ i, κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by
          rw [← Finset.mul_sum]
          ring
  have hd : (0 : ℝ) ≤ (d : ℝ) := Nat.cast_nonneg d
  nlinarith [hsq, hcs, hsum, sq_nonneg ‖(diagMax (fockSym κ) x : L2I (Occ d))‖,
    sq_nonneg ‖(x : L2I (Occ d))‖]

/-! ## The second Faris–Lavine inequality -/

/-- The commutator form is additive over the modes. -/
theorem commForm_fockH (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    commForm (fockH hκ) (diagMax (fockSym κ)) x
      = ∑ i, commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x := by
  rw [commForm_eq, fockH_apply, sum_inner]
  rw [show ((∑ i, (inner ℂ (ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))
      (diagMax (fockSym κ) x : L2I (Occ d)) : ℂ)).im)
      = ∑ i, (inner ℂ (ShiftData.shiftH (modeData hκ i) x : L2I (Occ d))
        (diagMax (fockSym κ) x : L2I (Occ d)) : ℂ).im from
    map_sum Complex.imAddGroupHom _ _]
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => (commForm_eq _ _ x).symm

/-- **The commutator bound for the many-mode Hamiltonian**:
`|⟪x, i[Ĥ, N̂]x⟫| ≤ (∑ᵢ(2κᵢ + 4κᵢ²)) ⟪x, N̂x⟫`.  The commutator does not vanish —
the momenta and the advection fields do not commute — but each mode's cross term
is dominated by the sum of the squares `πᵢ² + Vᵢ²`. -/
theorem fockH_commForm_bound (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    |commForm (fockH hκ) (diagMax (fockSym κ)) x|
      ≤ (∑ i, (2 * κ i + 4 * κ i ^ 2)) * quadForm (diagMax (fockSym κ)) x := by
  have hmode : ∀ i : Fin d,
      |commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x|
        ≤ (2 * κ i + 4 * κ i ^ 2) * quadForm (diagMax (fockSym κ)) x := by
    intro i
    have h := ShiftData.shiftH_commForm_bound (modeData hκ i) x
    have hc : 2 * ((modeData hκ i).step) * (1 / 4 + (modeData hκ i).K)
        = 2 * κ i + 4 * κ i ^ 2 := by
      simp only [modeData]
      ring
    rw [hc] at h
    exact h
  calc |commForm (fockH hκ) (diagMax (fockSym κ)) x|
      = |∑ i, commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x| := by
        rw [commForm_fockH]
    _ ≤ ∑ i, |commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x| :=
        Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i, (2 * κ i + 4 * κ i ^ 2) * quadForm (diagMax (fockSym κ)) x :=
        Finset.sum_le_sum fun i _ => hmode i
    _ = (∑ i, (2 * κ i + 4 * κ i ^ 2)) * quadForm (diagMax (fockSym κ)) x := by
        rw [Finset.sum_mul]

/-! ## The commutator is genuinely non-zero -/

/-- The test state `e_0 + e_{2eᵢ}`: the vacuum plus two quanta in the mode `i`. -/
noncomputable def testState (κ : Fin d → ℝ) (i₀ : Fin d) : maxDom (fockSym κ) :=
  ⟨(lp.single 2 (0 : Occ d) (1 : ℂ) + lp.single 2 (modeShift i₀ (0 : Occ d)) (1 : ℂ)
      : L2I (Occ d)),
    finiteModes_le_maxDom _ (Submodule.add_mem _ (lpSingle_mem_lpFiniteModes _ (1 : ℂ))
      (lpSingle_mem_lpFiniteModes _ (1 : ℂ)))⟩

theorem modeShift_zero_ne_zero (i : Fin d) : modeShift i (0 : Occ d) ≠ 0 := by
  intro h
  have hi := congrFun h i
  rw [modeShift_self] at hi
  simp at hi

theorem modeShift_zero_inj {i j : Fin d} (h : modeShift i (0 : Occ d) = modeShift j 0) :
    i = j := by
  by_contra hne
  have hi := congrFun h i
  rw [modeShift_self] at hi
  rw [modeShift, Function.update_of_ne hne] at hi
  simp at hi

theorem testState_coe (i₀ : Fin d) (β : Occ d) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β
      = if β = 0 then 1 else if β = modeShift i₀ 0 then 1 else 0 := by
  classical
  have hne : (0 : Occ d) ≠ modeShift i₀ 0 := Ne.symm (modeShift_zero_ne_zero i₀)
  simp only [testState, lp.coeFn_add, Pi.add_apply, lp.single_apply, Pi.single_apply]
  by_cases h0 : β = 0
  · subst h0
    simp [hne]
  · by_cases h1 : β = modeShift i₀ 0
    · subst h1
      simp [h0]
    · simp [h0, h1]

theorem testState_coe_zero (i₀ : Fin d) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0 = 1 := by
  rw [testState_coe, if_pos rfl]

theorem testState_coe_eq_zero (i₀ : Fin d) {β : Occ d}
    (h0 : β ≠ 0) (h1 : β ≠ modeShift i₀ 0) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β = 0 := by
  rw [testState_coe, if_neg h0, if_neg h1]

/-- Shifting twice in the same mode leaves the two-quantum sector. -/
theorem modeShift_shift_ne (i i₀ : Fin d) :
    modeShift i (modeShift i₀ (0 : Occ d)) ≠ 0 := by
  intro h
  have hi := congrFun h i
  rw [modeShift_self] at hi
  simp at hi

theorem modeShift_shift_ne' (i i₀ : Fin d) :
    modeShift i (modeShift i₀ (0 : Occ d)) ≠ modeShift i₀ 0 := by
  intro h
  have hi := congrFun h i
  rw [modeShift_self] at hi
  by_cases hii : i = i₀
  · subst hii
    rw [modeShift_self] at hi
    omega
  · rw [modeShift, Function.update_of_ne hii] at hi
    simp at hi

/-- The elementary vanishing criterion: the hopping term at `β` vanishes as soon as
the product of the two coefficients does. -/
theorem commTerm_eq_zero (hκ : ∀ i, 0 ≤ κ i) (i i₀ : Fin d) (β : Occ d)
    (hprod : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β
      * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) ((modeData hκ i).shift β) = 0) :
    2 * (modeData hκ i).step * ((modeData hκ i).amp β
      * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
        * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
          ((modeData hκ i).shift β)).re) = 0 := by
  rcases mul_eq_zero.mp hprod with h | h <;> rw [h] <;> simp

/-- Away from the excited mode the commutator form of the test state vanishes. -/
theorem commForm_testState_of_ne (hκ : ∀ i, 0 ≤ κ i) {i i₀ : Fin d} (hne : i ≠ i₀) :
    commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) (testState κ i₀) = 0 := by
  classical
  have hshift : ∀ β : Occ d, (modeData hκ i).shift β = modeShift i β := fun _ => rfl
  have hzero : ∀ β : Occ d,
      2 * (modeData hκ i).step * ((modeData hκ i).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i).shift β)).re) = 0 := by
    intro β
    refine commTerm_eq_zero hκ i i₀ β ?_
    rw [hshift]
    rcases eq_or_ne β 0 with rfl | h0
    · have h2 : modeShift i (0 : Occ d) ≠ modeShift i₀ 0 := fun h => hne (modeShift_zero_inj h)
      rw [testState_coe_eq_zero i₀ (modeShift_zero_ne_zero i) h2, mul_zero]
    · rcases eq_or_ne β (modeShift i₀ 0) with rfl | h1
      · rw [testState_coe_eq_zero i₀ (modeShift_shift_ne i i₀) (modeShift_shift_ne' i i₀),
          mul_zero]
      · rw [testState_coe_eq_zero i₀ h0 h1, zero_mul]
  have hs := ShiftData.hasSum_commForm (modeData hκ i) (testState κ i₀)
  have hz : HasSum (fun β : Occ d =>
      2 * (modeData hκ i).step * ((modeData hκ i).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i).shift β)).re)) 0 := by
    simp only [hzero]
    exact hasSum_zero
  exact hs.unique hz

/-- On the excited mode the commutator form of the test state is `2Δ w(0) ≠ 0`. -/
theorem commForm_testState_self (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) :
    commForm (ShiftData.shiftH (modeData hκ i₀)) (diagMax (fockSym κ)) (testState κ i₀)
      = 2 * (4 * κ i₀) * modeAmp κ i₀ 0 := by
  classical
  have hshift : ∀ β : Occ d, (modeData hκ i₀).shift β = modeShift i₀ β := fun _ => rfl
  have hs := ShiftData.hasSum_commForm (modeData hκ i₀) (testState κ i₀)
  simp only [modeData_sym] at hs
  have hsingle : HasSum (fun β : Occ d =>
      2 * (modeData hκ i₀).step * ((modeData hκ i₀).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i₀).shift β)).re))
      (2 * (modeData hκ i₀).step * ((modeData hκ i₀).amp 0
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i₀).shift 0)).re)) := by
    refine hasSum_single 0 fun β hβ => ?_
    refine commTerm_eq_zero hκ i₀ i₀ β ?_
    rw [hshift]
    rcases eq_or_ne β (modeShift i₀ 0) with rfl | h1
    · rw [testState_coe_eq_zero i₀ (modeShift_shift_ne i₀ i₀) (modeShift_shift_ne' i₀ i₀),
        mul_zero]
    · rw [testState_coe_eq_zero i₀ hβ h1, zero_mul]
  rw [hs.unique hsingle]
  have hshift0 : (modeData hκ i₀).shift 0 = modeShift i₀ 0 := rfl
  have hamp0 : (modeData hκ i₀).amp 0 = modeAmp κ i₀ 0 := rfl
  have hstep : (modeData hκ i₀).step = 4 * κ i₀ := rfl
  have hc0 : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0 = 1 := testState_coe_zero i₀
  have hc1 : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) (modeShift i₀ 0) = 1 := by
    rw [testState_coe, if_neg (modeShift_zero_ne_zero i₀), if_pos rfl]
  rw [hshift0, hamp0, hstep, hc0, hc1]
  simp

/-- **`i[Ĥ, N̂] ≠ 0`.**  For a positive strain rate in the mode `i₀`, the
commutator form of the many-mode Hamiltonian with its comparison operator is
strictly positive at the test state `e_0 + e_{2eᵢ₀}`: the Faris–Lavine bound
dominates a genuinely non-zero commutator. -/
theorem fock_commForm_ne_zero (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) (hpos : 0 < κ i₀) :
    commForm (fockH hκ) (diagMax (fockSym κ)) (testState κ i₀) ≠ 0 := by
  classical
  rw [commForm_fockH]
  rw [Finset.sum_eq_single i₀ (fun i _ hne => commForm_testState_of_ne hκ hne)
    (fun h => absurd (Finset.mem_univ i₀) h), commForm_testState_self]
  have hamp : 0 < modeAmp κ i₀ 0 := by
    have h : (0 : ℝ) < Real.sqrt ((((0 : Occ d) i₀ : ℝ) + 1) * (((0 : Occ d) i₀ : ℝ) + 2)) := by
      rw [Real.sqrt_pos]
      norm_num
    simp only [modeAmp]
    positivity
  positivity

/-! ## Essential self-adjointness -/

/-- **The many-mode (Fock-space) Navier–Stokes Hamiltonian
`Ĥ = ∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)` is essentially self-adjoint on the finite-configuration
core.**  Both Faris–Lavine inequalities are theorems here, mode by mode; the
criterion itself is `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`
and the Ikebe–Kato-type input is proved in
`BookProof.ChapterNavierStokesIkebeKato`.  Nothing is assumed. -/
theorem fockH_essentiallySelfAdjointOn_core (hκ : ∀ i, 0 ≤ κ i) :
    EssentiallySelfAdjointOn (lpFiniteModes (Occ d))
      ((fockH hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)))) := by
  refine essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds (fockSym κ)
    (fockSym_nonneg hκ) (fockH hκ) ((d : ℝ) ^ 2 / 2) (2 * d * ∑ i, κ i ^ 2)
    (∑ i, (2 * κ i + 4 * κ i ^ 2)) (fockH_symmetricOn hκ) ?_
    (fockH_relative_bound hκ) (fockH_commForm_bound hκ)
  exact Finset.sum_nonneg fun i _ => by nlinarith [hκ i]

end FockManyMode

end BookProof.NavierStokesFlow
