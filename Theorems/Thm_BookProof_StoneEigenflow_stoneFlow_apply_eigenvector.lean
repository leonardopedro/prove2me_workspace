-- Generated from ChapterStoneEigenflow.lean — theorem BookProof.StoneEigenflow.stoneFlow_apply_eigenvector
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
open BookProof.StoneBridge
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.StoneEigenflow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge


theorem BookProof.StoneEigenflow.stoneFlow_apply_eigenvector {T : UnboundedSelfAdjoint F} {U : ℝ → (F →L[ℂ] F)}
    (hU : IsStoneFlow T U) {x : F} (hx : x ∈ T.domain) {lam : ℝ}
    (hev : T.op ⟨x, hx⟩ = (lam : ℂ) • x) (t : ℝ) :
    U t x = Complex.exp (-(Complex.I * lam * t)) • x := by sorry
