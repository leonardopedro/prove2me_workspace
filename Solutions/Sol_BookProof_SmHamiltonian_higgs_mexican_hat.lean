-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.higgs_mexican_hat
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam mu q : ℝ) (hlam : 0 < lam) :
    lam / 4 * (q - mu ^ 2 / lam) ^ 2
      = -(mu ^ 2 / 2) * q + lam / 4 * q ^ 2 + mu ^ 4 / (4 * lam) := by

  field_simp
  ring
