-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.isGraphCore_of_esa
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterFarisLavineCore
open BookProof.FarisLavine
open BookProof.QgOuterFockFL
open BookProof.QgOuterFockCoreFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ScalaronFiberFL.isGraphCore_of_esa (C : Comparison F) (C₀ : Submodule ℂ F)
    (hle : C₀ ≤ C.dom) (P : C₀ →ₗ[ℂ] F)
    (hext : ∀ p : C₀, C.op ⟨(p : F), hle p.2⟩ = P p)
    (hesa : EssentiallySelfAdjointOn C₀ P) : IsGraphCore C C₀ := by sorry
