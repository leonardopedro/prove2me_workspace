-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.essentiallySelfAdjointOn_symSector
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable (P) in
variable (P) (D : Submodule ℂ F) in
variable {D : Submodule ℂ F}
variable (P D) in
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (T) in
variable (U : F →ₗ[ℂ] F)
variable {U}



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section


theorem BookProof.ReducedEsa.essentiallySelfAdjointOn_symSector (hU2 : ∀ x, U (U x) = x)
    (hUi : ∀ x y : F, (inner ℂ (U x) (U y) : ℂ) = inner ℂ x y)
    {hUD : ∀ x ∈ D, U x ∈ D} (hTU : ∀ x : D, T ⟨U (x : F), hUD _ x.2⟩ = U (T x))
    (hesa : EssentiallySelfAdjointOn D T) :
    EssentiallySelfAdjointOn (redDom (symProj U) D)
      (redOp T (isReducingProjection_symProj hU2 hUi) (commutes_symProj hTU)) := by sorry
