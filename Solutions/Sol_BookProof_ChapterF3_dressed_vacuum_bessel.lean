-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.dressed_vacuum_bessel
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {E' : Type*} [NormedAddCommGroup E'] [InnerProductSpace ℂ E']

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (x : ι → E') (hx : Orthonormal ℂ x)
    (v : E') (hv : ‖v‖ = 1) (s : Finset ι) :
    ∑ j ∈ s, ‖inner (𝕜 := by

  convert hx.sum_inner_products_le v using 1;
  rw [ hv, one_pow ]
