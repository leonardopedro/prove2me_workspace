-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
namespace BookProof.YangMillsFriedrichs

open BookProof.FarisLavine

/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The **form inner product** of a positive symmetric operator `H`:
`⟪x, y⟫_H = ⟪x, y⟫ + ⟪x, H y⟫`.  Its completion is the form domain of the
Friedrichs extension. -/
noncomputable def formInner (H : D →ₗ[ℂ] F) (x y : D) : ℂ := (hdense : Dense (D : Set F)) (hs
