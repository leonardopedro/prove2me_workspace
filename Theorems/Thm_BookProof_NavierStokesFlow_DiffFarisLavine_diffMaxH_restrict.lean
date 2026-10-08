-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxH_restrict
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxH_restrict :
    (diffMaxH A c).comp
        (Submodule.inclusion (polyGaussCore_le_diffMaxDom (velMu A (seqConst c))))
      = (polyGaussCore (d := 3)).subtype.comp (nsDiffH A c) := by sorry
