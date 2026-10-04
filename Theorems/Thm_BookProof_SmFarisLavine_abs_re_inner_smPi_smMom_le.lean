-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.abs_re_inner_smPi_smMom_le
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmFarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.SmFarisLavine.abs_re_inner_smPi_smMom_le (m : Fin 40) (x : polyGaussCore (d := 163)) :
    |(inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
        ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ).re|
      ≤ 1 / 2 * (‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
        + ‖((smMomField m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2) := by sorry
