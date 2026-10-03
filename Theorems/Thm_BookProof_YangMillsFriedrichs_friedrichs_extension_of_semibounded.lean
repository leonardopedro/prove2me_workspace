-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

namespace BookProof.YangMillsFriedrichs

open BookProof.FarisLavine

/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form


/-- The **form inner product** of a positive symmetric operator `H`:
`⟪x, y⟫_H = ⟪x, y⟫ + ⟪x, H y⟫`.  Its completion is the form domain of the
Friedrichs extension. -/
noncomputable def formInner (H : D →ₗ[ℂ] F) (x y : D) : ℂ := by sorry
