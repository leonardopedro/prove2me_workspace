import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_oscSymbol_step

import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom

import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Mathlib


/-!
# The **affine** Navier–Stokes fiber field: a `±1`-shift on top of the `±2`-shift

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities, and hence essential self-adjointness on the finite-mode core, for
the Navier–Stokes fiber Hamiltonian `H = ½(π V + V π)` with a **linear**
advection field `V(u) = κ u`.  `BookProof.ChapterNavierStokesBilinearEsa` lifts
that to the genuinely bilinear (quadratic-symbol) advection term by decomposing
`ℓ²(ℕ × J)` into blocks, one for each eigenvalue `κ_j` of the derivative field.

The boundary recorded there was the **affine** fiber field

`V(u) = κ u + c`,

which is what the viscous term `−ν u_{i,jj}` and the cross terms `u_j u_{i,j}`
with `j ≠ i` produce: they contribute a term that is *constant* in the velocity
mode `u_i` being differentiated.  In the Hermite basis of the fiber,
`½(π V + V π) = κ · ½(π u + u π) + c · π`, and while `½(π u + u π) =
(i/2)(a†² − a²)` is a `±2`-shift (the operator of `ChapterNavierStokes‐
HermiteFarisLavine`), the extra term `c · π = (i c/√2)(a† − a)` is a **`±1`
shift**.  This module removes that boundary.

## The instrument: sums of shift Hamiltonians

The Faris–Lavine hypotheses used in this project
(`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`) are

* `H` symmetric, `N ≥ 0` with `N + 1` surjective,
* a **relative bound** `‖Hx‖² ≤ a‖Nx‖² + b‖x‖²` — with *no* smallness
  requirement on `a`, and
* a **commutator bound** `|⟪x, i[H, N]x⟫| ≤ c ⟪x, Nx⟫`.

All three are stable under sums: `‖(H₁+H₂)x‖² ≤ 2‖H₁x‖² + 2‖H₂x‖²` and the
commutator form is additive in `H`.  So two shift Hamiltonians sharing one
comparison operator may simply be added.  That is the content of `PairShift`
below: a single symbol `σ` carrying two shifts at once.

## What is proved

* `PairShift.pairH` — the sum of two shift Hamiltonians with a common comparison
  symbol, on the maximal domain of that symbol;
* `PairShift.pairH_symmetricOn`, `PairShift.pairH_relative_bound`,
  `PairShift.pairH_commForm_bound` — the two Faris–Lavine inequalities for the
  sum, with explicit constants;
* `PairShift.pairH_essentiallySelfAdjointOn_core` — the sum is essentially
  self-adjoint on the finite-mode core;
* `affH` — the affine Navier–Stokes fiber Hamiltonian `½(π V + V π)` for
  `V(u) = κ u + c`, in the Hermite basis of `ℓ²(ℕ)`;
* `affH_symmetricOn`, `affH_essentiallySelfAdjointOn_core` — **the headline**:
  the affine fiber Hamiltonian is symmetric and essentially self-adjoint on the
  finite-mode core, for all `κ ≥ 0` and `c ≥ 0`;
* `affH_coord_succ` and `affH_coord_succ_succ` — the two matrix entries of `H`
  on a Hermite basis vector: the `±1`-hopping `(c/√2)√(n+1)` of the constant
  part and the `±2`-hopping `(κ/2)√((n+1)(n+2))` of the linear part;
* `affH_ne_zero_of_pos_shear` and `affH_not_bounded` — the `±1`-hopping really
  is present when `c > 0`, and the operator is genuinely unbounded when
  `κ > 0`.

## Honest boundary

`c ≥ 0` is assumed, only because a `ShiftData` amplitude is required to be
non-negative; the case `c < 0` is the conjugate of the case `|c|` by the
sign-flip unitary `x_n ↦ (−1)ⁿ x_n`, which reverses the sign of a `±1`-hopping
and preserves a `±2`-hopping — that unitary equivalence is *not* formalized
here, so nothing below is claimed for `c < 0`.  The comparison operator used is
`N = μ(2n+1) + 1` with `μ = κ + c + 1`, i.e. the harmonic-oscillator number
operator rescaled so as to dominate both amplitudes.  As in the modules quoted
above, everything is stated on the abstract sequence space `ℓ²(ℕ)` with the
operator given by its matrix in the Hermite basis; the differential realization
on `L²(du)` is not built here.  Only one velocity component is carried, and
nothing here claims global regularity for the classical Navier–Stokes equation.
-/

namespace PairShift

variable (P : PairShift ι)

/-- The first of the two shift Hamiltonians packaged by `P`. -/
@[reducible] def fst : ShiftData ι where
  sym := P.sym
  shift := P.shift₁
  amp := P.amp₁
  K := P.K
  step := P.step₁
  shift_injective := P.shift₁_injective
  amp_nonneg := P.amp₁_nonneg
  amp_mono := P.amp₁_mono
  K_nonneg := P.K_nonneg
  step_nonneg := P.step₁_nonneg
  sym_ge_one := P.sym_ge_one
  amp_le := P.amp₁_le
  sym_step := P.sym_step₁

/-- The second of the two shift Hamiltonians packaged by `P`. -/
@[reducible] def snd : ShiftData ι where
  sym := P.sym
  shift := P.shift₂
  amp := P.amp₂
  K := P.K
  step := P.step₂
  shift_injective := P.shift₂_injective
  amp_nonneg := P.amp₂_nonneg
  amp_mono := P.amp₂_mono
  K_nonneg := P.K_nonneg
  step_nonneg := P.step₂_nonneg
  sym_ge_one := P.sym_ge_one
  amp_le := P.amp₂_le
  sym_step := P.sym_step₂

@[simp] theorem fst_sym : P.fst.sym = P.sym := rfl
@[simp] theorem snd_sym : P.snd.sym = P.sym := rfl
@[simp] theorem fst_shift : P.fst.shift = P.shift₁ := rfl
@[simp] theorem snd_shift : P.snd.shift = P.shift₂ := rfl
@[simp] theorem fst_amp : P.fst.amp = P.amp₁ := rfl
@[simp] theorem snd_amp : P.snd.amp = P.amp₂ := rfl

/-- **The two-shift Hamiltonian**: the sum of the two shift Hamiltonians, on the
maximal domain of the common comparison symbol. -/
noncomputable def pairH : maxDom P.sym →ₗ[ℂ] L2I ι :=
  ShiftData.shiftH P.fst + ShiftData.shiftH P.snd

theorem pairH_apply (x : maxDom P.sym) :
    (pairH P x : L2I ι) = (ShiftData.shiftH P.fst x : L2I ι)
      + (ShiftData.shiftH P.snd x : L2I ι) := rfl

theorem pairH_coe (x : maxDom P.sym) (β : ι) :
    ((pairH P x : L2I ι) : ι → ℂ) β
      = P.fst.hFun ((x : L2I ι) : ι → ℂ) β + P.snd.hFun ((x : L2I ι) : ι → ℂ) β := by
  rw [pairH_apply, lp.coeFn_add]
  rfl

/-- The two-shift Hamiltonian is symmetric on the maximal domain. -/
theorem pairH_symmetricOn : SymmetricOn (maxDom P.sym) (pairH P) := by
  intro x y
  have h₁ : (inner ℂ (ShiftData.shiftH P.fst x : L2I ι) (y : L2I ι) : ℂ)
      = inner ℂ (x : L2I ι) (ShiftData.shiftH P.fst y : L2I ι) :=
    ShiftData.shiftH_symmetricOn P.fst x y
  have h₂ : (inner ℂ (ShiftData.shiftH P.snd x : L2I ι) (y : L2I ι) : ℂ)
      = inner ℂ (x : L2I ι) (ShiftData.shiftH P.snd y : L2I ι) :=
    ShiftData.shiftH_symmetricOn P.snd x y
  change (inner ℂ (pairH P x : L2I ι) (y : L2I ι) : ℂ) = inner ℂ (x : L2I ι) (pairH P y : L2I ι)
  rw [pairH_apply, pairH_apply, inner_add_left, inner_add_right, h₁, h₂]

/-- **The first Faris–Lavine inequality for a two-shift Hamiltonian**:
`‖Hx‖² ≤ 2‖Nx‖² + 32K²‖x‖²`.  (No smallness of the coefficient of `‖Nx‖²` is
needed: the Faris–Lavine criterion only uses the relative bound to transport the
conclusion from the maximal domain to a core.) -/
theorem pairH_relative_bound (x : maxDom P.sym) :
    ‖(pairH P x : L2I ι)‖ ^ 2
      ≤ 2 * ‖(diagMax P.sym x : L2I ι)‖ ^ 2 + (32 * P.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by
  have h₁ := ShiftData.shiftH_relative_bound P.fst x
  have h₂ := ShiftData.shiftH_relative_bound P.snd x
  have htri : ‖(pairH P x : L2I ι)‖
      ≤ ‖(ShiftData.shiftH P.fst x : L2I ι)‖ + ‖(ShiftData.shiftH P.snd x : L2I ι)‖ := by
    rw [pairH_apply]; exact norm_add_le _ _
  have hsq : ‖(pairH P x : L2I ι)‖ ^ 2
      ≤ 2 * ‖(ShiftData.shiftH P.fst x : L2I ι)‖ ^ 2
        + 2 * ‖(ShiftData.shiftH P.snd x : L2I ι)‖ ^ 2 := by
    nlinarith [norm_nonneg (pairH P x : L2I ι), norm_nonneg (ShiftData.shiftH P.fst x : L2I ι),
      norm_nonneg (ShiftData.shiftH P.snd x : L2I ι),
      sq_nonneg (‖(ShiftData.shiftH P.fst x : L2I ι)‖
        - ‖(ShiftData.shiftH P.snd x : L2I ι)‖)]
  have hK : P.fst.K = P.K := rfl
  have hK' : P.snd.K = P.K := rfl
  rw [hK] at h₁
  rw [hK'] at h₂
  have hsym : (diagMax P.fst.sym x : L2I ι) = (diagMax P.sym x : L2I ι) := rfl
  have hsym' : (diagMax P.snd.sym x : L2I ι) = (diagMax P.sym x : L2I ι) := rfl
  rw [hsym] at h₁
  rw [hsym'] at h₂
  linarith

/-- **The second Faris–Lavine inequality for a two-shift Hamiltonian**:
`|⟪x, i[H,N]x⟫| ≤ (2Δ₁ + 2Δ₂)(¼ + K) ⟪x, Nx⟫`. -/
theorem pairH_commForm_bound (x : maxDom P.sym) :
    |commForm (pairH P) (diagMax P.sym) x|
      ≤ (2 * P.step₁ * (1 / 4 + P.K) + 2 * P.step₂ * (1 / 4 + P.K))
        * quadForm (diagMax P.sym) x := by
  have h₁ := ShiftData.shiftH_commForm_bound P.fst x
  have h₂ := ShiftData.shiftH_commForm_bound P.snd x
  have hadd : commForm (pairH P) (diagMax P.sym) x
      = commForm (ShiftData.shiftH P.fst) (diagMax P.sym) x
        + commForm (ShiftData.shiftH P.snd) (diagMax P.sym) x :=
    commForm_add _ _ _ x
  have e₁ : commForm (ShiftData.shiftH P.fst) (diagMax P.fst.sym) x
      = commForm (ShiftData.shiftH P.fst) (diagMax P.sym) x := rfl
  have e₂ : commForm (ShiftData.shiftH P.snd) (diagMax P.snd.sym) x
      = commForm (ShiftData.shiftH P.snd) (diagMax P.sym) x := rfl
  have q₁ : quadForm (diagMax P.fst.sym) x = quadForm (diagMax P.sym) x := rfl
  have q₂ : quadForm (diagMax P.snd.sym) x = quadForm (diagMax P.sym) x := rfl
  rw [e₁, q₁] at h₁
  rw [e₂, q₂] at h₂
  have hK₁ : P.fst.K = P.K := rfl
  have hK₂ : P.snd.K = P.K := rfl
  have hs₁ : P.fst.step = P.step₁ := rfl
  have hs₂ : P.snd.step = P.step₂ := rfl
  rw [hK₁, hs₁] at h₁
  rw [hK₂, hs₂] at h₂
  rw [hadd]
  refine le_trans (abs_add_le _ _) ?_
  linarith

/-- **A two-shift Hamiltonian is essentially self-adjoint on the finite-mode
core.** -/
theorem pairH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((pairH P).comp (Submodule.inclusion (finiteModes_le_maxDom P.sym))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds P.sym
    (fun β => le_trans zero_le_one (P.sym_ge_one β))
    (pairH P) 2 (32 * P.K ^ 2)
    (2 * P.step₁ * (1 / 4 + P.K) + 2 * P.step₂ * (1 / 4 + P.K))
    (pairH_symmetricOn P)
    (by nlinarith [P.step₁_nonneg, P.step₂_nonneg, P.K_nonneg])
    (pairH_relative_bound P) (pairH_commForm_bound P)

end PairShift

/-! ## The affine Navier–Stokes fiber Hamiltonian -/

/-- The comparison strength for the affine fiber field `V(u) = κ u + c`: large
enough to dominate both the `±2`-hopping `(κ/2)√((n+1)(n+2))` and the
`±1`-hopping `(c/√2)√(n+1)`. -/
noncomputable def affMu (κ c : ℝ) : ℝ := κ + c + 1

/-- The `±1`-hopping amplitude of `c · π = (i c/√2)(a† − a)`. -/
noncomputable def shear (c : ℝ) (n : ℕ) : ℝ := (c / Real.sqrt 2) * Real.sqrt (n + 1)

theorem shear_nonneg {c : ℝ} (hc : 0 ≤ c) (n : ℕ) : 0 ≤ shear c n := by
  unfold shear
  positivity

theorem shear_mono {c : ℝ} (hc : 0 ≤ c) (n : ℕ) : shear c n ≤ shear c (n + 1) := by
  unfold shear
  have h : Real.sqrt ((n : ℝ) + 1) ≤ Real.sqrt (((n : ℝ) + 1) + 1) :=
    Real.sqrt_le_sqrt (by linarith)
  have hcast : ((n + 1 : ℕ) : ℝ) + 1 = ((n : ℝ) + 1) + 1 := by push_cast; ring
  rw [hcast]
  have : 0 ≤ c / Real.sqrt 2 := by positivity
  exact mul_le_mul_of_nonneg_left h this

theorem sqrt_succ_le (n : ℕ) : Real.sqrt ((n : ℝ) + 1) ≤ ((n : ℝ) + 2) / 2 := by
  have hnn : (0 : ℝ) ≤ (n : ℝ) + 1 := by positivity
  have hsq : Real.sqrt ((n : ℝ) + 1) ^ 2 = (n : ℝ) + 1 := Real.sq_sqrt hnn
  nlinarith [Real.sqrt_nonneg ((n : ℝ) + 1), sq_nonneg (Real.sqrt ((n : ℝ) + 1) - 1)]

theorem shear_le {c : ℝ} (hc : 0 ≤ c) {κ : ℝ} (hκ : 0 ≤ κ) (n : ℕ) :
    shear c n ≤ (1 / 4) * oscSymbol (affMu κ c) n + (κ + c) := by
  have hs : Real.sqrt ((n : ℝ) + 1) ≤ ((n : ℝ) + 2) / 2 := sqrt_succ_le n
  have h2 : (1 : ℝ) ≤ Real.sqrt 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2), Real.sqrt_nonneg 2]
  have hdiv : c / Real.sqrt 2 ≤ c := by
    rw [div_le_iff₀ (by linarith)]
    nlinarith
  have hstep : shear c n ≤ c * (((n : ℝ) + 2) / 2) := by
    unfold shear
    have hpos : 0 ≤ c / Real.sqrt 2 := by positivity
    calc (c / Real.sqrt 2) * Real.sqrt ((n : ℝ) + 1)
        ≤ (c / Real.sqrt 2) * (((n : ℝ) + 2) / 2) := mul_le_mul_of_nonneg_left hs hpos
      _ ≤ c * (((n : ℝ) + 2) / 2) := by
          have : (0 : ℝ) ≤ ((n : ℝ) + 2) / 2 := by positivity
          exact mul_le_mul_of_nonneg_right hdiv this
  have hnn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  unfold oscSymbol affMu
  nlinarith

theorem amp_le_affine {κ : ℝ} (hκ : 0 ≤ κ) {c : ℝ} (hc : 0 ≤ c) (n : ℕ) :
    amp κ n ≤ (1 / 4) * oscSymbol (affMu κ c) n + (κ + c) := by
  have hsq : Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2)) ≤ (n : ℝ) + 2 := by
    have hnn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
    have h := Real.sqrt_le_sqrt (show ((n : ℝ) + 1) * ((n : ℝ) + 2) ≤ ((n : ℝ) + 2) ^ 2 by
      nlinarith)
    rwa [Real.sqrt_sq (by linarith)] at h
  have hnn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have hstep : amp κ n ≤ (κ / 2) * ((n : ℝ) + 2) := by
    unfold amp
    exact mul_le_mul_of_nonneg_left hsq (by positivity)
  unfold oscSymbol affMu
  nlinarith

/-- The two-shift data of the **affine** Navier–Stokes fiber field
`V(u) = κ u + c`: the `±2`-hopping of `κ · ½(π u + u π)` and the `±1`-hopping of
`c · π`, both dominated by the number operator `μ(2n+1)+1` with
`μ = κ + c + 1`. -/
noncomputable def affData {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) : PairShift ℕ where
  sym := oscSymbol (affMu κ c)
  shift₁ := fun n => n + 2
  shift₂ := fun n => n + 1
  amp₁ := amp κ
  amp₂ := shear c
  K := κ + c
  step₁ := 4 * affMu κ c
  step₂ := 2 * affMu κ c
  shift₁_injective := fun a b hab => by simpa using hab
  shift₂_injective := fun a b hab => by simpa using hab
  amp₁_nonneg := amp_nonneg hκ
  amp₂_nonneg := shear_nonneg hc
  amp₁_mono := amp_le_amp_add_two hκ
  amp₂_mono := shear_mono hc
  K_nonneg := by linarith
  step₁_nonneg := by unfold affMu; linarith
  step₂_nonneg := by unfold affMu; linarith
  sym_ge_one := oscSymbol_ge_one (by unfold affMu; linarith)
  amp₁_le := amp_le_affine hκ hc
  amp₂_le := shear_le hc hκ
  sym_step₁ := fun n => oscSymbol_step n
  sym_step₂ := fun n => by unfold oscSymbol; push_cast; ring

@[simp] theorem affData_sym {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).sym = oscSymbol (affMu κ c) := rfl

/-- **The affine Navier–Stokes fiber Hamiltonian** `H = ½(π V + V π)` for the
affine advection field `V(u) = κ u + c`, in the Hermite basis of `ℓ²(ℕ)`: the
`±2`-hopping `(κ/2)√((n+1)(n+2))` of the linear part plus the `±1`-hopping
`(c/√2)√(n+1)` of the constant part. -/
noncomputable def affH {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    maxDom (oscSymbol (affMu κ c)) →ₗ[ℂ] L2I ℕ :=
  PairShift.pairH (affData hκ hc)

/-- The affine fiber Hamiltonian is symmetric on the maximal domain of the
comparison operator. -/
theorem affH_symmetricOn {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    SymmetricOn (maxDom (oscSymbol (affMu κ c))) (affH hκ hc) :=
  PairShift.pairH_symmetricOn (affData hκ hc)

/-- **The affine Navier–Stokes fiber Hamiltonian is essentially self-adjoint on
the finite-mode core.**  This removes the `±1`-shift boundary recorded in
`ChapterNavierStokesBilinearEsa`: the viscous term and the cross terms, which
add a constant to the fiber field, are covered. -/
theorem affH_essentiallySelfAdjointOn_core {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((affH hκ hc).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu κ c))))) :=
  PairShift.pairH_essentiallySelfAdjointOn_core (affData hκ hc)

/-! ## The `±1`-hopping is genuinely present -/

@[simp] theorem affData_shift₁ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).shift₁ = fun n : ℕ => n + 2 := rfl

@[simp] theorem affData_shift₂ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).shift₂ = fun n : ℕ => n + 1 := rfl

@[simp] theorem affData_amp₁ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).amp₁ = amp κ := rfl

@[simp] theorem affData_amp₂ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).amp₂ = shear c := rfl

/-- The Hermite basis vector `eₙ`, as an element of the maximal domain of the
comparison operator. -/
noncomputable def basisState (κ c : ℝ) (n : ℕ) : maxDom (oscSymbol (affMu κ c)) :=
  ⟨lp.single 2 n (1 : ℂ), finiteModes_le_maxDom _ (lpSingle_mem_lpFiniteModes _ _)⟩

theorem basisState_coe (κ c : ℝ) (n m : ℕ) :
    ((basisState κ c n : L2I ℕ) : ℕ → ℂ) m = if m = n then 1 else 0 := by
  simp [basisState, lp.single_apply, Pi.single_apply, eq_comm]

theorem norm_basisState (κ c : ℝ) (n : ℕ) : ‖(basisState κ c n : L2I ℕ)‖ = 1 := by
  simp [basisState]

/-- The coordinate of `H eₙ` at Hermite level `n + 1` is exactly the
`±1`-hopping amplitude `(c/√2)√(n+1)`: the constant part of the affine field
really acts, and it acts through the shift that the linear part cannot
produce. -/
theorem affH_coord_succ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) (n : ℕ) :
    ((affH hκ hc (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 1)
      = Complex.I * ((shear c n : ℝ) : ℂ) := by
  have hX := basisState_coe κ c n
  have hfst : (affData hκ hc).fst.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 1) = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₁] at hα
      rw [hX]
      have : α ≠ n := by omega
      simp [this]
    · simp only [PairShift.fst_shift, affData_shift₁, hX]
      norm_num
      omega
  have hsnd : (affData hκ hc).snd.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 1)
      = Complex.I * ((shear c n : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData hκ hc).snd
      (X := ((basisState κ c n : L2I ℕ) : ℕ → ℂ)) (o := n)
      (by simp [hX]) (by simp [hX]; omega)
    simpa using h
  change ((PairShift.pairH (affData hκ hc) (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 1) = _
  have hp1 := PairShift.pairH_coe (P := affData hκ hc) (basisState κ c n) (n + 1)
  refine hp1.trans ?_
  rw [hfst, hsnd, zero_add]

/-- The coordinate of `H eₙ` at Hermite level `n + 2` is the `±2`-hopping
amplitude `(κ/2)√((n+1)(n+2))` of the linear part. -/
theorem affH_coord_succ_succ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) (n : ℕ) :
    ((affH hκ hc (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 2)
      = Complex.I * ((amp κ n : ℝ) : ℂ) := by
  have hX := basisState_coe κ c n
  have hsnd : (affData hκ hc).snd.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 2) = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₂] at hα
      rw [hX]
      have : α ≠ n := by omega
      simp [this]
    · simp only [PairShift.snd_shift, affData_shift₂, hX]
      norm_num
      omega
  have hfst : (affData hκ hc).fst.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 2)
      = Complex.I * ((amp κ n : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData hκ hc).fst
      (X := ((basisState κ c n : L2I ℕ) : ℕ → ℂ)) (o := n)
      (by simp [hX]) (by simp [hX]; omega)
    simpa using h
  change ((PairShift.pairH (affData hκ hc) (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 2) = _
  have hp2 := PairShift.pairH_coe (P := affData hκ hc) (basisState κ c n) (n + 2)
  refine hp2.trans ?_
  rw [hfst, hsnd, add_zero]

/-- With a non-zero constant part the affine fiber Hamiltonian does not vanish
on the ground state: the `±1`-shift is not an artefact of the bookkeeping. -/
theorem affH_ne_zero_of_pos_shear {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 < c) :
    affH hκ hc.le (basisState κ c 0) ≠ 0 := by
  intro h0
  have hcoord := affH_coord_succ hκ hc.le 0
  rw [h0] at hcoord
  simp only [lp.coeFn_zero, Pi.zero_apply] at hcoord
  have hshear : shear c 0 ≠ 0 := by
    have h2 : (0 : ℝ) < Real.sqrt 2 := by rw [Real.sqrt_pos]; norm_num
    have h1 : (0 : ℝ) < Real.sqrt (((0 : ℕ) : ℝ) + 1) := by rw [Real.sqrt_pos]; norm_num
    unfold shear
    positivity
  have hz : ((shear c 0 : ℝ) : ℂ) = 0 := by
    have h := hcoord.symm
    field_simp at h
    simpa using h
  exact hshear (by exact_mod_cast hz)

/-! ## The operator is genuinely unbounded -/

theorem le_amp {κ : ℝ} (hκ : 0 ≤ κ) (n : ℕ) : (κ / 2) * ((n : ℝ) + 1) ≤ amp κ n := by
  have hnn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have hle : ((n : ℝ) + 1) ≤ Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2)) := by
    have h := Real.sqrt_le_sqrt (show ((n : ℝ) + 1) ^ 2 ≤ ((n : ℝ) + 1) * ((n : ℝ) + 2) by
      nlinarith)
    rwa [Real.sqrt_sq (by linarith)] at h
  unfold amp
  exact mul_le_mul_of_nonneg_left hle (by positivity)

/-- The affine fiber Hamiltonian is unbounded: essential self-adjointness above
is not a boundedness phenomenon. -/
theorem affH_not_bounded {κ c : ℝ} (hκ : 0 < κ) (hc : 0 ≤ c) (C : ℝ) :
    ∃ n : ℕ, ‖(basisState κ c n : L2I ℕ)‖ = 1
      ∧ C < ‖(affH hκ.le hc (basisState κ c n) : L2I ℕ)‖ := by
  obtain ⟨n, hn⟩ := exists_nat_gt (2 * (|C| + 1) / κ)
  refine ⟨n, norm_basisState κ c n, ?_⟩
  have hb : ‖((affH hκ.le hc (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 2)‖
      ≤ ‖(affH hκ.le hc (basisState κ c n) : L2I ℕ)‖ :=
    lp.norm_apply_le_norm (by norm_num) _ _
  rw [affH_coord_succ_succ] at hb
  have hnv : ‖Complex.I * ((amp κ n : ℝ) : ℂ)‖ = amp κ n := by
    rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (amp_nonneg hκ.le n)]
  rw [hnv] at hb
  have hlow := le_amp hκ.le n
  have hgt : 2 * (|C| + 1) / κ < (n : ℝ) := hn
  have hmul : 2 * (|C| + 1) < κ * (n : ℝ) := by
    rw [div_lt_iff₀ hκ] at hgt
    linarith [hgt]
  have hC : C ≤ |C| := le_abs_self C
  nlinarith

/-- The finite-mode core is dense, so the affine fiber Hamiltonian is a densely
defined operator and its essential self-adjointness is the statement it should
be. -/
theorem affH_domain_dense :
    Dense ((lpFiniteModes ℕ : Submodule ℂ (L2I ℕ)) : Set (L2I ℕ)) :=
  lpFiniteModes_dense

end AffineFiber

end BookProof.NavierStokesFlow
