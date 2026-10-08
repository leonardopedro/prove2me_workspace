-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.nsBrst_not_hermitian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.GhostField
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix
open BookProof.NavierStokesFlow

theorem BookProof.NavierStokesEulerian.nsBrst_not_hermitian {n : ℕ} (d : NSTruncation n) (h : nsDivergence d ≠ 0) :
    (nsBrstCharge d)ᴴ ≠ nsBrstCharge d := by sorry
