-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.quadForm_le
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
theorem solution (P : SmParams) (u : polyGaussCore (d := 163)) :
    quadForm (smHamiltonian P) u ≤ ‖(u : L2d 163)‖ * ‖smHamiltonian P u‖ := (Complex.re_le_norm _).trans (norm_inner_le_norm _ _)
