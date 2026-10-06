-- Generated from ChapterSmHamiltonian.lean — theorem BookProof.SmHamiltonian.wall_sq
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
open BookProof.SmHamiltonian

variable {D : ℕ}



open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.SmHamiltonian.wall_sq (P : SmParams) (q : ℝ) :
    1 / 2 * (Real.sqrt (P.lam / 2) * (q - P.vev ^ 2)) ^ 2
      = P.lam / 4 * (q - P.vev ^ 2) ^ 2 := by sorry
