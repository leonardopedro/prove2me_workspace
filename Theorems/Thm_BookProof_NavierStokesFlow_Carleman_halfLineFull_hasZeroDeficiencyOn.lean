-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.halfLineFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.halfLineFull_hasZeroDeficiencyOn (c : Fin 15 → ℕ → ℝ) (nu : ℝ)
    (hcar : ¬ Summable fun n => 1 / ‖nsCoupling (halfLineSymbol c nu) n‖) :
    HasZeroDeficiencyOn (halfLineFullData c nu).D (halfLineFullData c nu).hamiltonian := by sorry
