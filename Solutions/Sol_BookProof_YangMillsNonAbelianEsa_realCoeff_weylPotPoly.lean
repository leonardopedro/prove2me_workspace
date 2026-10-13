-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.realCoeff_weylPotPoly
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_add
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.YangMillsHermite

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {Φ : Fin r → MvPolynomial (Fin d) ℂ} (hΦ : ∀ j, RealCoeff (Φ j)) :
    RealCoeff (weylPotPoly Φ) := (RealCoeff.sum fun j _ => (hΦ j).mul (hΦ j)).add (realCoeff_C_real_prime 1)
