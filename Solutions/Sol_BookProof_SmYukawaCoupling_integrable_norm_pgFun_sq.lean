-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.integrable_norm_pgFun_sq
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterSmHamiltonian
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
import Definitions.Def_ChapterHermiteProductCore
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin 163) ℂ) :
    Integrable (fun x : Vd 163 => ‖pgFun p x‖ ^ 2) := (memLp_pgFun p).integrable_norm_pow two_ne_zero
