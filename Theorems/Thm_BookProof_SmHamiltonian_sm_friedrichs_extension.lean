-- Generated from ChapterSmHamiltonian.lean — theorem BookProof.SmHamiltonian.sm_friedrichs_extension
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
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

theorem BookProof.SmHamiltonian.sm_friedrichs_extension (P : SmParams) :
    ∃ (Dom : Submodule ℂ (L2d 163)) (A : Dom →ₗ[ℂ] L2d 163),
      IsPositiveSelfAdjointExtension (smHamiltonian P) A := by sorry
