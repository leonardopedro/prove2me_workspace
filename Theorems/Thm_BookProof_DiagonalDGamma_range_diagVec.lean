-- Generated from ChapterDiagonalDGammaEsa.lean — theorem BookProof.DiagonalDGamma.range_diagVec
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.DiagonalDGamma.range_diagVec :
    (Set.range fun i => ((diagVec hE i : Hs.carrier))) = Set.range E := by sorry
