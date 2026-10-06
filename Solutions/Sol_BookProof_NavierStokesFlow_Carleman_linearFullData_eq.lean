-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.linearFullData_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution : linearFullData = halfLineFullData linearMode 1 := rfl
