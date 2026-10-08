-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.hermiteMvLp_mem_range
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

theorem BookProof.NavierStokesFlow.DiffFarisLavine.hermiteMvLp_mem_range (a : Fin 3 →₀ ℕ) :
    hermiteMvLp a
      ∈ Submodule.map ((polyGaussCore (d := 3)).subtype) (LinearMap.range embedCore) := by sorry
