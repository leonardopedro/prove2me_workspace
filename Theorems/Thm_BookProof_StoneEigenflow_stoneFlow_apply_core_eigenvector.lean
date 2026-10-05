-- Generated from ChapterStoneEigenflow.lean — theorem BookProof.StoneEigenflow.stoneFlow_apply_core_eigenvector
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.StoneBridge
open BookProof.StoneEigenflow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge


theorem BookProof.StoneEigenflow.stoneFlow_apply_core_eigenvector {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {T : UnboundedSelfAdjoint F} {U : ℝ → (F →L[ℂ] F)}
    (hext : IsSelfAdjointExtension Hc T.op) (hU : IsStoneFlow T U) (x : D) {lam : ℝ}
    (hx : Hc x = (lam : ℂ) • (x : F)) (t : ℝ) :
    U t (x : F) = Complex.exp (-(Complex.I * lam * t)) • (x : F) := by sorry
