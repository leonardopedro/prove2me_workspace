-- Generated from ChapterSmYukawaCoupling.lean — theorem BookProof.SmYukawaCoupling.real_relBound
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
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
open BookProof.SmYukawaCoupling



open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

theorem BookProof.SmYukawaCoupling.real_relBound {φ w s h q l c ε : ℝ} (hl : 0 < l) (hc : 0 ≤ c) (hε : 0 < ε)
    (hs : 0 ≤ s) (hh : 0 ≤ h) (hφ0 : 0 ≤ φ)
    (h1 : φ ^ 2 ≤ 2 / l * w ^ 2 + c * s ^ 2) (h2 : w ^ 2 ≤ 2 * q) (h3 : q ≤ s * h) :
    φ ≤ ε * h + Real.sqrt ((4 / l) ^ 2 / (4 * ε ^ 2) + c) * s := by sorry
