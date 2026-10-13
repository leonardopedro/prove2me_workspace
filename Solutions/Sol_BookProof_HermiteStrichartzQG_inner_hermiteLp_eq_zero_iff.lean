-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.inner_hermiteLp_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteCore_hermiteBasis_apply
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized
open BookProof.FarisLavine
open BookProof.HermiteCore

set_option maxHeartbeats 1000000 in

theorem solution {w : L2R} :
    (∀ n : ℕ, (inner ℂ (hermiteLp n) w : ℂ) = 0) ↔ w = 0 := by
  constructor
  · intro h
    have hrep : hermiteRepr w = 0 := by
      ext n
      simpa [hermiteRepr, HilbertBasis.repr_apply_apply] using h n
    have := congrArg hermiteRepr.symm hrep
    simpa using this
  · rintro rfl n
    simp

/-! ## The Hermite core -/
