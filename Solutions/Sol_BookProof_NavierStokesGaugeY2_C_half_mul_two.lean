-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.C_half_mul_two
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution : (C (1 / 2 : ℂ) : NSAlg) * 2 = 1 := by

  rw [(map_ofNat C 2).symm, ← C_mul]
  norm_num
