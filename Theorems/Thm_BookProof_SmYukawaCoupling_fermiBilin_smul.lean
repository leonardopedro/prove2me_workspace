-- Generated from ChapterSmYukawaCoupling.lean — theorem BookProof.SmYukawaCoupling.fermiBilin_smul
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
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
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore

noncomputable section

theorem BookProof.SmYukawaCoupling.fermiBilin_smul {n : ℕ} (c : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    fermiBilin (c • A) = c • fermiBilin A := by sorry
