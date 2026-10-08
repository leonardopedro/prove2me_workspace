-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.quadForm_nsDiffN_embedCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
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
open BookProof.NavierStokesFlow.DiffFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.DiffFarisLavine.quadForm_nsDiffN_embedCore (mu : ℝ) (x : lpFiniteModes Vel) :
    quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) (embedCore x)
      = quadForm (diagMax (velSym mu))
          (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x) := by sorry
