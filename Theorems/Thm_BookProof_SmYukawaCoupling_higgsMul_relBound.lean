-- Generated from ChapterSmYukawaCoupling.lean — theorem BookProof.SmYukawaCoupling.higgsMul_relBound
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOneParticle
open BookProof.YangMillsHermite
open BookProof.SmYukawaCoupling



open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

theorem BookProof.SmYukawaCoupling.higgsMul_relBound (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4) :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : polyGaussCore (d := 163),
      ‖higgsMul a u‖ ≤ ε * ‖smHamiltonian P u‖ + C * ‖(u : L2d 163)‖ := by sorry
