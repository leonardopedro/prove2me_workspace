-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.linearFull_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.linearFull_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : linearFullData.D, ‖linearFullData.hamiltonian f‖ ≤ C * ‖f‖ := by sorry
