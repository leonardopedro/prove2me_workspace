-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.im_inner_smHamiltonian_smQL
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
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

theorem BookProof.SmFarisLavine.im_inner_smHamiltonian_smQL (P : SmParams) (x : polyGaussCore (d := 163)) :
    (inner ℂ (smHamiltonian P x) (smQL x) : ℂ).im
      = 1 / 2 * ∑ m : Fin 40, (-2) *
          (inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
            ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ).re := by sorry
