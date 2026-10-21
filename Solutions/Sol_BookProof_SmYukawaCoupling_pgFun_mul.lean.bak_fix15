-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.pgFun_mul
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
theorem solution (q p : MvPolynomial (Fin 163) ℂ) (x : Vd 163) :
    pgFun (q * p) x = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q * pgFun p x := by

  simp only [pgFun, map_mul]
  ring
