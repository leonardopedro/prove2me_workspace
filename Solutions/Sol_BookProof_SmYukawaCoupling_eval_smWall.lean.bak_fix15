-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.eval_smWall
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
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
theorem solution (P : SmParams) (x : Vd 163) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (smWall P (id : Fin 163 → Fin 163))
      = ((wallVal P x : ℝ) : ℂ) := by

  rw [smWall, MvPolynomial.smul_eq_C_mul]
  simp only [map_mul, map_sub, map_sum, eval_X, eval_C, id, wallVal]
  push_cast
  ring_nf
