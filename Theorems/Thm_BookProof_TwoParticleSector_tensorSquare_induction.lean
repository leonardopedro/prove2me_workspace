-- Generated from ChapterTwoParticleSectorEsa.lean — theorem BookProof.TwoParticleSector.tensorSquare_induction
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
open BookProof.TwoParticleSector



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

theorem BookProof.TwoParticleSector.tensorSquare_induction {Y : Type} [NormedAddCommGroup Y] [InnerProductSpace ℂ Y]
    {P : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ) → Prop} (hzero : P 0)
    (htmul : ∀ (x y : Y) (c : ℂ), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ)) : P t := by sorry
