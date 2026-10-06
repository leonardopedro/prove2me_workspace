-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.nsBrst_symmetrization_hermitian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.nsBrst_symmetrization_hermitian {n : ℕ} (d : NSTruncation n) :
    (nsBrstCharge d + (nsBrstCharge d)ᴴ)ᴴ = nsBrstCharge d + (nsBrstCharge d)ᴴ := by sorry
