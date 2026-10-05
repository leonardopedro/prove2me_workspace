-- Generated from ChapterYangMillsNonAbelianEsa.lean — theorem BookProof.YangMillsNonAbelianEsa.ym_dGamma_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YangMillsNonAbelianEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}



open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

theorem BookProof.YangMillsNonAbelianEsa.ym_dGamma_esa (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 99) (polyGaussCore (d := 99))
        (polyGaussCore (d := 99)) n))
      (dGammaCoreOp (L2dSpace 99) (polyGaussCore (d := 99))
        (ymHamiltonian (coreRepPoly 99) fabc) (polyGaussCore (d := 99))) := by sorry
