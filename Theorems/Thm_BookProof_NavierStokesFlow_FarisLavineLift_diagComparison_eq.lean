-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift




open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagComparisonData d p q).comparison
      = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by sorry
