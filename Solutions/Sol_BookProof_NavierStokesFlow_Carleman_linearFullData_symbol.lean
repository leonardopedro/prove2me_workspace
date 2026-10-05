-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.linearFullData_symbol
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution : halfLineSymbol linearMode 1 = fun m : ℕ => (m : ℝ) + 1 := by

  funext n
  simp only [halfLineSymbol, halfLineAlpha, linearMode, Fin.sum_univ_three]
  norm_num [nsVelIdx, nsGradIdx, nsLapIdx, Fin.ext_iff]
