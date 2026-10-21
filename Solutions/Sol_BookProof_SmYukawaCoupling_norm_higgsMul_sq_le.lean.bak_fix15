-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.norm_higgsMul_sq_le
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_higgs_sq_le
import Theorems.Thm_BookProof_SmYukawaCoupling_pgFun_mul
import Theorems.Thm_BookProof_SmYukawaCoupling_eval_smWall
import Theorems.Thm_BookProof_SmYukawaCoupling_integrable_norm_pgFun_sq
import Theorems.Thm_BookProof_QgHermiteFriedrichs_norm_sq_pgLp
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4)
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
