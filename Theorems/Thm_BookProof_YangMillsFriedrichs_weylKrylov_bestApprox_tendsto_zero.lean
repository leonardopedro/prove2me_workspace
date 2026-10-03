-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_tendsto_zero
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH9
open BookProof.ChapterH5
open BookProof.ChapterH9
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace BookProof.YangMillsFriedrichs

open BookProof.FarisLavine

/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form


/-- The **form inner product** of a positive symmetric operator `H`:
`⟪x, y⟫_H = ⟪x, y⟫ + ⟪x, H y⟫`.  Its completion is the form domain of the
Friedrichs extension. -/
noncomputable def formInner (H : D →ₗ[ℂ] F) (x y : D) : ℂ := by sorry
