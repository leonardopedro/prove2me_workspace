import Mathlib

/-!
# Quantization due to time-evolution: the Weyl relations from conjugation

This file formalizes the self-contained algebraic content of the book's section
**"Quantization due to time evolution"** (from the chapter *"Quantization due to
time-evolution: Yang-Mills and Classical Statistical Field Theory"*, `book.tex`
line ~6802).  The book's central claim there is that *quantization* — the
appearance of the canonical commutation relations of position and momentum
(strictly, the **Weyl relations**, the exponentiated form of the CCR) — is a
consequence of a **non-deterministic time-evolution** acting by conjugation.

The mechanism used in the book is the Trotter / Baker–Campbell–Hausdorff formula
`e^{εA} e^{B} e^{-εA} = e^{B - ε[A,B] + O(ε²)}`, together with the concrete
`e^{iεp²} e^{ix} e^{-iεp²} = e^{i(x+εp)}` (conjugating the exponentiated position
by a kinetic time-step shifts it by the momentum — "the time-derivative of the
position operator is the momentum operator").

The full CCR `[x,p] = i·1` has **no finite-dimensional representation** (a trace
argument forbids it).  The honest finite-dimensional model that captures exactly
the structure the book uses is the **Heisenberg algebra / group**: three
`3×3` real matrices

* `Xgen = e₁₂`  (the "position" generator),
* `Ygen = e₂₃`  (the "momentum" generator),
* `Zgen = e₁₃`  (the central element `[X,Y]`),

with the defining relations `[X,Y] = Z`, `Z` central, and `X² = Y² = Z² = 0`.
Here every element is nilpotent so the exponential series terminates and all the
BCH/Trotter identities become **exact** (no `O(ε²)` remainder): this is the
Heisenberg group, whose group law is precisely the exponentiated CCR.

Main results (all `sorry`-free, `axiom`-free beyond `propext`/`Classical.choice`/
`Quot.sound`):

* `comm_XY` — the CCR `[X,Y] = Z`, and `comm_scaled` its scaled form
  `[aX, bY] = (ab)Z`;
* `Zgen_central`, `Zgen_sq` — `Z` is central and squares to zero;
* `Heis_mul` — the Heisenberg **group law**
  `H(a,b,c)·H(a',b',c') = H(a+a', b+b', c+c'+a·b')`;
* `exp_Ngen` — the exponential map `exp(aX+bY+cZ) = H(a, b, c + ab/2)`;
* `weyl` — the **Weyl relation** `exp(aX)·exp(bY) = exp(aX + bY + (ab/2)Z)`
  (the exponentiated CCR / BCH product formula, exact here);
* `weyl_shift` — the **conjugation / quantization identity**
  `exp(aX)·exp(bY)·exp(-aX) = exp(bY + (ab)Z) = exp(bY + a[X,Y])`,
  the finite-dimensional model of the book's `e^{εA}e^{B}e^{-εA}=e^{B-ε[A,B]}`
  and of `e^{iεp²}e^{ix}e^{-iεp²}=e^{i(x+εp)}`: conjugating the "momentum"
  one-parameter subgroup by the "position" time-step shifts it in the central
  `[X,Y]` direction.
-/

open NormedSpace
open scoped Matrix

namespace BookProof.QuantizationWeyl

/- We equip the `3×3` real matrices with the (local, non-canonical) `ℓ∞`
operator norm so that `NormedSpace.exp` has its series available. -/
attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

/-- The algebra of `3×3` real matrices, the ambient algebra of the model. -/
abbrev M := Matrix (Fin 3) (Fin 3) ℝ

/-- The "position" generator `X = e₁₂`. -/
def Xgen : M := !![0,1,0;0,0,0;0,0,0]

/-- The "momentum" generator `Y = e₂₃`. -/
def Ygen : M := !![0,0,0;0,0,1;0,0,0]

/-- The central generator `Z = e₁₃ = [X,Y]`. -/
def Zgen : M := !![0,0,1;0,0,0;0,0,0]

/-- A general element `aX + bY + cZ` of the Heisenberg (nilpotent) subalgebra. -/
def Ngen (a b c : ℝ) : M := !![0,a,c;0,0,b;0,0,0]

/-- A general element `H(a,b,c) = I + aX + bY + cZ` of the Heisenberg group. -/
def Heis (a b c : ℝ) : M := !![1,a,c;0,1,b;0,0,1]

/-- The canonical commutation relation `[X, Y] = Z`. -/
theorem comm_XY : Xgen * Ygen - Ygen * Xgen = Zgen := by
  unfold Xgen Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp 

/-- The central generator `Z` commutes with both `X` and `Y` (and in fact
`XZ = ZX = YZ = ZY = 0`). -/
theorem Zgen_central : Xgen * Zgen = 0 ∧ Zgen * Xgen = 0 ∧ Ygen * Zgen = 0 ∧ Zgen * Ygen = 0 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    · first
        | (unfold Xgen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
            simp [Matrix.mul_apply, Fin.sum_univ_three])
        | (unfold Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
            simp [Matrix.mul_apply, Fin.sum_univ_three])

/-- The central generator squares to zero. -/
theorem Zgen_sq : Zgen ^ 2 = 0 := by
  unfold Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp [pow_succ, Matrix.mul_apply, Fin.sum_univ_three]

/-- The scaled canonical commutation relation `[aX, bY] = (ab)Z`, the model of
`[x,p] = i·1` after rescaling. -/
theorem comm_scaled (a b : ℝ) :
    (a • Xgen) * (b • Ygen) - (b • Ygen) * (a • Xgen) = (a * b) • Zgen := by
  unfold Xgen Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp

/-- The Heisenberg **group law**
`H(a,b,c)·H(a',b',c') = H(a+a', b+b', c+c'+a·b')`.  This is the exponentiated
CCR: the failure of `c` to be simply additive (the `a·b'` term) is the Weyl
cocycle. -/
theorem Heis_mul (a b c a' b' c' : ℝ) :
    Heis a b c * Heis a' b' c' = Heis (a + a') (b + b') (c + c' + a * b') := by
  unfold Heis; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_three] <;> ring

/-- `aX + bY + cZ = N(a,b,c)`, i.e. `Ngen` is the general Heisenberg-algebra
element written in the `X, Y, Z` basis. -/
theorem Ngen_eq (a b c : ℝ) : a • Xgen + b • Ygen + c • Zgen = Ngen a b c := by
  unfold Xgen Ygen Zgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- The cube of any Heisenberg-algebra element vanishes (three-step nilpotency),
so its exponential series terminates. -/
theorem Ngen_cube (a b c : ℝ) : (Ngen a b c) ^ 3 = 0 := by
  unfold Ngen; ext i j; fin_cases i <;> fin_cases j <;>
    simp [pow_succ, Matrix.mul_apply, Fin.sum_univ_three]

/-- The square of a Heisenberg-algebra element is `(ab)Z`. -/
theorem Ngen_sq (a b c : ℝ) : (Ngen a b c) ^ 2 = (a * b) • Zgen := by
  unfold Ngen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp [pow_succ, Matrix.mul_apply, Fin.sum_univ_three]

/-- The **exponential map** of the Heisenberg algebra:
`exp(aX + bY + cZ) = H(a, b, c + ab/2)`.  Since the algebra element is nilpotent
of order three, the exponential series is exactly `1 + N + N²/2`. -/
theorem exp_Ngen (a b c : ℝ) :
    NormedSpace.exp (Ngen a b c) = Heis a b (c + a * b / 2) := by
  have hcube := Ngen_cube a b c
  have h := congrFun (NormedSpace.exp_eq_tsum ℝ (𝔸 := M)) (Ngen a b c)
  rw [h, tsum_eq_sum (s := Finset.range 3) ?_]
  · rw [Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_one, Ngen_sq]
    unfold Ngen Zgen Heis
    ext i j; fin_cases i <;> fin_cases j <;>
      simp [Matrix.add_apply, pow_succ] ; ring
  · intro k hk
    simp only [Finset.mem_range, not_lt] at hk
    have : (Ngen a b c) ^ k = 0 := by
      obtain ⟨t, rfl⟩ := Nat.exists_eq_add_of_le hk
      rw [pow_add, hcube, zero_mul]
    rw [this, smul_zero]

theorem smul_Xgen (a : ℝ) : a • Xgen = Ngen a 0 0 := by
  unfold Xgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

theorem smul_Ygen (b : ℝ) : b • Ygen = Ngen 0 b 0 := by
  unfold Ygen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

theorem sum_XYZ (a b : ℝ) :
    a • Xgen + b • Ygen + (a * b / 2) • Zgen = Ngen a b (a * b / 2) := by
  unfold Xgen Ygen Zgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

theorem sum_YZ (a b : ℝ) : b • Ygen + (a * b) • Zgen = Ngen 0 b (a * b) := by
  unfold Ygen Zgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

theorem smul_neg_Xgen (a : ℝ) : -(a • Xgen) = Ngen (-a) 0 0 := by
  unfold Xgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- The **Weyl relation** (the exponentiated CCR / exact BCH product formula):
`exp(aX)·exp(bY) = exp(aX + bY + (ab/2)Z)`.  The central `(ab/2)Z` correction is
exactly `½[aX, bY]`, the second Baker–Campbell–Hausdorff term, which is exact
here because all higher commutators vanish. -/
theorem weyl (a b : ℝ) :
    NormedSpace.exp (a • Xgen) * NormedSpace.exp (b • Ygen)
      = NormedSpace.exp (a • Xgen + b • Ygen + (a * b / 2) • Zgen) := by
  rw [sum_XYZ, smul_Xgen, smul_Ygen, exp_Ngen, exp_Ngen, exp_Ngen, Heis_mul]
  norm_num

/-- The **conjugation / quantization identity**: conjugating the "momentum"
one-parameter subgroup `exp(bY)` by the "position" time-step `exp(aX)` shifts it
by `a[X,Y] = (ab)Z`:
`exp(aX)·exp(bY)·exp(-aX) = exp(bY + (ab)Z)`.
This is the finite-dimensional, exact version of the book's Trotter/BCH identity
`e^{εA} e^{B} e^{-εA} = e^{B - ε[A,B]}` and of the concrete
`e^{iεp²} e^{ix} e^{-iεp²} = e^{i(x+εp)}`: the momentum appears as the
"time-derivative of the position" under the non-commutative (non-deterministic)
time-evolution. -/
theorem weyl_shift (a b : ℝ) :
    NormedSpace.exp (a • Xgen) * NormedSpace.exp (b • Ygen) * NormedSpace.exp (-(a • Xgen))
      = NormedSpace.exp (b • Ygen + (a * b) • Zgen) := by
  rw [sum_YZ, smul_neg_Xgen, smul_Xgen, smul_Ygen,
    exp_Ngen, exp_Ngen, exp_Ngen, exp_Ngen, Heis_mul, Heis_mul]
  norm_num

end BookProof.QuantizationWeyl
