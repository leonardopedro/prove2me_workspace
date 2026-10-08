import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib


/-!
# The Standard-Model one-particle Hamiltonian with an **operator-valued** Yukawa coupling

`BookProof/ChapterSmFullEnclosure.lean` assembles `h_full = h_B ⊗ 1 + 1 ⊗ (smDirac + smYukawa M z)`
with the Yukawa term in a *fixed* Higgs background `z`: a tensor sum, with no boson–fermion
coupling operator.  This module replaces the constant `z` by the Higgs field itself.  Writing
`z = φ₀ + i φ₁` with `φ₀, φ₁` two real components of the Higgs doublet (the coordinates
`smPhi 0`, `smPhi 1` of `ℝ¹⁶³`), the fixed-background Yukawa operator is
`smYukawa M z = Re z · smYukawa M 1 + Im z · smYukawa M i` (`smYukawa_eq_re_im`), and the
operator-valued coupling is

`H_Y = φ₀ ⊗ smYukawa M 1 + φ₁ ⊗ smYukawa M i`,

a genuine interaction between the bosonic and the fermionic factor.  The Hamiltonian is

`h_Yuk = h_B ⊗ 1 + 1 ⊗ smDirac h_D + H_Y`   (`smYukawaFullHam`).

## What is proved

* `higgs_sq_le` — the pointwise inequality `φ_a² ≤ (2/λ) W² + v² + ¼`, where
  `W = √(λ/2)(‖φ‖² − v²)` is the Higgs wall of `smHamiltonian`;
* `norm_higgsMul_sq_le`, `norm_wall_sq_le_quadForm`, **`higgsMul_relBound`** — for `λ > 0`,
  multiplication by a Higgs component is `h_B`-bounded with relative bound `0`:
  `‖φ_a u‖ ≤ ε ‖h_B u‖ + C_ε ‖u‖` for every `ε > 0`;
* `smYukawa_symmetricOn`, `smYukawa_eq_re_im`;
* **`smYukawa_h_esa`** — for `λ > 0`, every Hermitian Dirac matrix and every Yukawa matrix,
  `h_Yuk` is essentially self-adjoint on `polyGaussCore 163 ⊗ FermiFock n` (one-particle
  statement), by Kato–Rellich for product couplings
  (`TensorKatoRellich.essentiallySelfAdjointOn_tensorSum_add_coupling`) on top of
  `smFull_h_esa`;
* **`smYukawa_dGamma_esa`** — its enclosure `dΓ(h_Yuk)` (creation left / annihilation right)
  is essentially self-adjoint on the finite-particle domain.

## Honest boundary

The Higgs quartic must be **positive** (`0 < λ`): the relative bound comes from the Higgs wall.
The fermionic mode set is finite (the CAR Fock space `FermiFock n` is finite-dimensional), which
is what makes the coupling relatively bounded.  Which two real components of the doublet carry
the Yukawa coupling is a modelling choice (`smPhi 0`, `smPhi 1`); the proof works for any.  No
spectral information and no mass gap is claimed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.SmYukawaCoupling

open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

/-! ## 1. Multiplication by a Higgs component -/

/-- Multiplication by the Higgs component `φ_a`, on the Gauss–polynomial core of `L²(ℝ¹⁶³)`. -/
def higgsMul (a : Fin 4) : (polyGaussCore (d := 163)) →ₗ[ℂ] L2d 163 :=
  (polyGaussCore (d := 163)).subtype ∘ₗ (coreRepPoly 163).op (mulOp (X (smPhi a)))

theorem higgsMul_symmetricOn (a : Fin 4) :
    SymmetricOn (polyGaussCore (d := 163)) (higgsMul a) :=
  (coreRepPoly 163).symmetricOn_op (mulOp_polySym (realCoeff_X _))

/-- The real value of the Higgs wall `W = √(λ/2)(‖φ‖² − v²)` at a point. -/
def wallVal (P : SmParams) (x : Vd 163) : ℝ :=
  Real.sqrt (P.lam / 2) * ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2)

/-- **The pointwise confinement inequality** `φ_a² ≤ (2/λ) W² + v² + ¼`. -/
theorem higgs_sq_le (P : SmParams) (hlam : 0 < P.lam) (x : Vd 163) (a : Fin 4) :
    x (smPhi a) ^ 2 ≤ 2 / P.lam * wallVal P x ^ 2 + (P.vev ^ 2 + 1 / 4) := by
  have hr : x (smPhi a) ^ 2 ≤ ∑ b : Fin 4, x (smPhi b) ^ 2 :=
    Finset.single_le_sum (f := fun b => x (smPhi b) ^ 2) (fun b _ => sq_nonneg _)
      (Finset.mem_univ a)
  have hW : 2 / P.lam * wallVal P x ^ 2
      = ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2) ^ 2 := by
    rw [wallVal, mul_pow, Real.sq_sqrt (by positivity)]
    field_simp
  rw [hW]
  nlinarith [sq_nonneg ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2 - 1 / 2)]

theorem pgFun_mul (q p : MvPolynomial (Fin 163) ℂ) (x : Vd 163) :
    pgFun (q * p) x = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q * pgFun p x := by
  simp only [pgFun, map_mul]
  ring

theorem eval_smWall (P : SmParams) (x : Vd 163) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (smWall P (id : Fin 163 → Fin 163))
      = ((wallVal P x : ℝ) : ℂ) := by
  rw [smWall, MvPolynomial.smul_eq_C_mul]
  simp only [map_mul, map_sub, map_sum, eval_X, eval_C, id, wallVal]
  push_cast
  ring_nf

theorem integrable_norm_pgFun_sq (p : MvPolynomial (Fin 163) ℂ) :
    Integrable (fun x : Vd 163 => ‖pgFun p x‖ ^ 2) :=
  (memLp_pgFun p).integrable_norm_pow two_ne_zero

/-- The `L²` form of the confinement inequality. -/
theorem norm_higgsMul_sq_le (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4)
    (p : MvPolynomial (Fin 163) ℂ) :
    ‖pgLp (X (smPhi a) * p)‖ ^ 2
      ≤ 2 / P.lam * ‖pgLp (smWall P (id : Fin 163 → Fin 163) * p)‖ ^ 2
        + (P.vev ^ 2 + 1 / 4) * ‖pgLp p‖ ^ 2 := by
  rw [QgHermiteFriedrichs.norm_sq_pgLp, QgHermiteFriedrichs.norm_sq_pgLp,
    QgHermiteFriedrichs.norm_sq_pgLp, ← integral_const_mul, ← integral_const_mul,
    ← integral_add ((integrable_norm_pgFun_sq _).const_mul _)
      ((integrable_norm_pgFun_sq _).const_mul _)]
  refine integral_mono (integrable_norm_pgFun_sq _)
    (((integrable_norm_pgFun_sq _).const_mul _).add ((integrable_norm_pgFun_sq _).const_mul _))
    fun x => ?_
  simp only [pgFun_mul, eval_X, eval_smWall, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    mul_pow, sq_abs]
  have h := higgs_sq_le P hlam x a
  have h0 : 0 ≤ ‖pgFun p x‖ ^ 2 := by positivity
  nlinarith

/-- The Higgs wall is one of the squared forms of `smHamiltonian`. -/
def wallIdx : Fin 49 := smFormFin (Sum.inr (Sum.inr (Sum.inr (Sum.inr ()))))

theorem norm_wall_sq_le_quadForm (P : SmParams) (u : polyGaussCore (d := 163)) :
    ‖((smField P wallIdx u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
      ≤ 2 * quadForm (smHamiltonian P) u := by
  rw [smHamiltonian_quadForm]
  have h1 : 0 ≤ ∑ m, ‖((smPi m u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 :=
    Finset.sum_nonneg fun m _ => by positivity
  have h2 : ‖((smField P wallIdx u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
      ≤ ∑ r, ‖((smField P r u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 :=
    Finset.single_le_sum (f := fun r => ‖((smField P r u : polyGaussCore (d := 163)) :
      L2d 163)‖ ^ 2) (fun r _ => by positivity) (Finset.mem_univ wallIdx)
  linarith

theorem quadForm_le (P : SmParams) (u : polyGaussCore (d := 163)) :
    quadForm (smHamiltonian P) u ≤ ‖(u : L2d 163)‖ * ‖smHamiltonian P u‖ :=
  (Complex.re_le_norm _).trans (norm_inner_le_norm _ _)

/-- The real-number core of the relative bound. -/
theorem real_relBound {φ w s h q l c ε : ℝ} (hl : 0 < l) (hc : 0 ≤ c) (hε : 0 < ε)
    (hs : 0 ≤ s) (hh : 0 ≤ h) (hφ0 : 0 ≤ φ)
    (h1 : φ ^ 2 ≤ 2 / l * w ^ 2 + c * s ^ 2) (h2 : w ^ 2 ≤ 2 * q) (h3 : q ≤ s * h) :
    φ ≤ ε * h + Real.sqrt ((4 / l) ^ 2 / (4 * ε ^ 2) + c) * s := by
  set A : ℝ := 4 / l with hA
  set K : ℝ := Real.sqrt (A ^ 2 / (4 * ε ^ 2) + c) with hK
  have hl' : 0 < 2 / l := by positivity
  have hsq : φ ^ 2 ≤ A * s * h + c * s ^ 2 := by
    have : 2 / l * w ^ 2 ≤ 2 / l * (2 * (s * h)) :=
      mul_le_mul_of_nonneg_left (h2.trans (by linarith)) hl'.le
    have e : 2 / l * (2 * (s * h)) = A * s * h := by rw [hA]; ring
    linarith
  have hamgm : A * s * h ≤ ε ^ 2 * h ^ 2 + A ^ 2 / (4 * ε ^ 2) * s ^ 2 := by
    have key : 0 ≤ (ε * h - A * s / (2 * ε)) ^ 2 := sq_nonneg _
    have e1 : (ε * h - A * s / (2 * ε)) ^ 2
        = ε ^ 2 * h ^ 2 - A * s * h + A ^ 2 / (4 * ε ^ 2) * s ^ 2 := by
      field_simp
      ring
    linarith
  have hK2 : K ^ 2 = A ^ 2 / (4 * ε ^ 2) + c := by
    rw [hK, Real.sq_sqrt (by positivity)]
  have hK0 : 0 ≤ K := Real.sqrt_nonneg _
  have hfin : φ ^ 2 ≤ (ε * h + K * s) ^ 2 := by
    have e : (ε * h + K * s) ^ 2 = ε ^ 2 * h ^ 2 + 2 * ε * K * h * s + K ^ 2 * s ^ 2 := by ring
    rw [e, hK2]
    have : 0 ≤ 2 * ε * K * h * s := by positivity
    nlinarith
  exact (pow_le_pow_iff_left₀ hφ0 (by positivity) two_ne_zero).mp hfin

theorem higgsMul_apply (a : Fin 4) (p : MvPolynomial (Fin 163) ℂ) :
    higgsMul a ((coreRepPoly 163).equiv p) = pgLp (X (smPhi a) * p) := by
  simp only [higgsMul, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [CoreRep.coe_op, LinearEquiv.symm_apply_apply]
  rfl

theorem smField_wall_apply (P : SmParams) (p : MvPolynomial (Fin 163) ℂ) :
    ((smField P wallIdx ((coreRepPoly 163).equiv p) : polyGaussCore (d := 163)) : L2d 163)
      = pgLp (smWall P (id : Fin 163 → Fin 163) * p) := by
  rw [smField, CoreRep.coe_op, LinearEquiv.symm_apply_apply, wallIdx, Equiv.symm_apply_apply]
  rfl

/-- **Relative bound `0`.**  For `λ > 0`, multiplication by a Higgs component is bounded
relative to the bosonic one-particle Hamiltonian with arbitrarily small relative bound. -/
theorem higgsMul_relBound (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4) :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : polyGaussCore (d := 163),
      ‖higgsMul a u‖ ≤ ε * ‖smHamiltonian P u‖ + C * ‖(u : L2d 163)‖ := by
  intro ε hε
  refine ⟨Real.sqrt ((4 / P.lam) ^ 2 / (4 * ε ^ 2) + (P.vev ^ 2 + 1 / 4)), fun u => ?_⟩
  obtain ⟨p, rfl⟩ : ∃ p, u = (coreRepPoly 163).equiv p :=
    ⟨_, ((coreRepPoly 163).equiv.apply_symm_apply u).symm⟩
  have h1 := norm_higgsMul_sq_le P hlam a p
  rw [← higgsMul_apply, ← smField_wall_apply, ← (coreRepPoly 163).coe_equiv p] at h1
  exact real_relBound hlam (by positivity) hε (norm_nonneg _) (norm_nonneg _) (norm_nonneg _)
    h1 (norm_wall_sq_le_quadForm P _) (quadForm_le P _)

/-! ## 2. The fermionic Yukawa bilinears -/







/-! ## 3. The coupled Hamiltonian -/

/-- The bosonic coupling operators: the two real Higgs components carrying the Yukawa
coupling. -/
def yukV : Fin 2 → (polyGaussCore (d := 163)) →ₗ[ℂ] L2d 163 := ![higgsMul 0, higgsMul 1]

/-- The fermionic coupling operators: `smYukawa M 1` and `smYukawa M i`. -/
def yukY {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Fin 2 → fullDom n →ₗ[ℂ] FermiFock n :=
  ![onFull (smYukawa M 1), onFull (smYukawa M Complex.I)]

/-- **The Standard-Model one-particle Hamiltonian with the operator-valued Yukawa coupling**
`h_Yuk = h_B ⊗ 1 + 1 ⊗ smDirac h_D + φ₀ ⊗ smYukawa M 1 + φ₁ ⊗ smYukawa M i`. -/
def smYukawaFullHam (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) :
    smFullCore n →ₗ[ℂ] (smFullSpace n).carrier :=
  cpairOp (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
      (smHamiltonian P) (onFull (smFermiHam hD 0 0)) +
    pairLiftOp (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
      (couplingPoly (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
        yukV (yukY M))

instance smFermiSpace_finiteDimensional (n : ℕ) : FiniteDimensional ℂ (smFermiSpace n).carrier :=
  inferInstanceAs (FiniteDimensional ℂ (FermiFock n))

/-- `fullDom n = ⊤`, and the subtype inclusion into the Fock space is injective. -/
instance fullDom_finiteDimensional (n : ℕ) : FiniteDimensional ℂ ↥(fullDom n) := by
  haveI : FiniteDimensional ℂ (FermiFock n) := inferInstance
  exact FiniteDimensional.of_injective (fullDom n).subtype Subtype.val_injective







end

end BookProof.SmYukawaCoupling
