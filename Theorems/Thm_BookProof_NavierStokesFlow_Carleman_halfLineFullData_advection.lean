-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.halfLineFullData_advection
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.halfLineFullData_advection (c : Fin 15 → ℕ → ℝ) (nu : ℝ) (i : Fin 3) :
    (halfLineFullData c nu).advection i = diagOp (halfLineAlpha c nu i) := by sorry
