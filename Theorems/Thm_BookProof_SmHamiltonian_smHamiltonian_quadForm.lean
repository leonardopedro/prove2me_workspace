-- Generated from ChapterSmHamiltonian.lean — theorem BookProof.SmHamiltonian.smHamiltonian_quadForm
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.SmHamiltonian

variable {D : ℕ}



open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.SmHamiltonian.smHamiltonian_quadForm (P : SmParams) (x : polyGaussCore (d := 163)) :
    quadForm (smHamiltonian P) x
      = 1 / 2 * (∑ m, ‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2)
        + 1 / 2 * ∑ r, ‖((smField P r x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 := by sorry
