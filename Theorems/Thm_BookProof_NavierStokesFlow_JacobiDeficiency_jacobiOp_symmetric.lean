-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency


open scoped ENNReal

tor -/

theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_symmetric (x y : lpFiniteModes ℕ) :
    (inner ℂ ((jacobiOp x : lpFiniteModes ℕ) : L2N) ((y : lpFiniteModes ℕ) : L2N) : ℂ)
      = inner ℂ ((x : lpFiniteModes ℕ) : L2N) ((jacobiOp y : lpFiniteModes ℕ) := by sorry
