-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.isGraphCore_of_esa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterA4
open BookProof.GraphCore
open BookProof.QgOuterFockFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.isGraphCore_of_esa (C : Comparison F) (C₀ : Submodule ℂ F) (hle : C₀ ≤ C.dom)
    (P : C₀ →ₗ[ℂ] F) (hext : ∀ p : C₀, C.op ⟨(p : F), hle p.2⟩ = P p)
    (hesa : EssentiallySelfAdjointOn C₀ P) : IsGraphCore C C₀ := by sorry
