-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsDivergenceConstraint_resolution
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsDivergenceConstraint_resolution (u11 u22 u33 : ℝ) (h : u33 = -(u11 + u22)) :
    u11 + u22 + u33 = 0 := by sorry
