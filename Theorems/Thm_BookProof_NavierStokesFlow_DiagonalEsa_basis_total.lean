-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.DiagonalEsa.basis_total
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa


open scoped ENNReal

theorem BookProof.NavierStokesFlow.DiagonalEsa.basis_total (w : L2N) (hw : ∀ n, (inner ℂ ((basis n : lpFiniteModes ℕ) : L2N) w : ℂ) = 0) :
    w = 0 := by sorry
