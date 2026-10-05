-- Generated from ChapterG.lean — solution of BookProof.ChapterG.one_mem_gaugeInvariantSubalgebra
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} (π : X → Y) :
    (1 : X → ℝ) ∈ gaugeInvariantSubalgebra ℝ π := by

  intro g _ x; rfl
