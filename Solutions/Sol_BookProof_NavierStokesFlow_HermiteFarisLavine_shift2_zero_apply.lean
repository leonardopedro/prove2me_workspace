-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.shift2_zero_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution {M : Type*} [Zero M] (g : ℕ → M) : shift2 g 0 = 0 := rfl
