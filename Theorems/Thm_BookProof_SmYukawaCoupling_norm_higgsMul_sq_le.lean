-- Generated from ChapterSmYukawaCoupling.lean — theorem BookProof.SmYukawaCoupling.norm_higgsMul_sq_le
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
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
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOneParticle
open BookProof.SmYukawaCoupling



open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

theorem BookProof.SmYukawaCoupling.norm_higgsMul_sq_le (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4)
    (p : MvPolynomial (Fin 163) ℂ) :
    ‖pgLp (X (smPhi a) * p)‖ ^ 2
      ≤ 2 / P.lam * ‖pgLp (smWall P (id : Fin 163 → Fin 163) * p)‖ ^ 2
        + (P.vev ^ 2 + 1 / 4) * ‖pgLp p‖ ^ 2 := by sorry
