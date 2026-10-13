-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.quadForm_le
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (u : polyGaussCore (d := 163)) :
    quadForm (smHamiltonian P) u ≤ ‖(u : L2d 163)‖ * ‖smHamiltonian P u‖ := (Complex.re_le_norm _).trans (norm_inner_le_norm _ _)
