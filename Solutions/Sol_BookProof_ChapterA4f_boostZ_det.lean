-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.boostZ_det
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution {l : ℂ} (hl : l ≠ 0) : (boostZ l).det = 1 := by

  unfold boostZ; simp [ hl, Matrix.det_fin_two ] ;
