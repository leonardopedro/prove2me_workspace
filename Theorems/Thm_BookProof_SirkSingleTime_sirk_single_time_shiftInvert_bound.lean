-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.sirk_single_time_shiftInvert_bound
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.ChapterH4
open BookProof.ChapterH6
open BookProof.ChapterSirkEndToEnd
open BookProof.SirkSingleTime

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}
variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.SirkSingleTime.sirk_single_time_shiftInvert_bound
    (A : UnboundedSelfAdjoint E) (l t : ℝ)
    (V : Fin' →L[ℂ] E) (qX qXinv : E →L[ℂ] E) (qBinv : Fin' →L[ℂ] Fin')
    (p : Polynomial ℂ) (psiB : Fin' →L[ℂ] Fin') (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ Fin')
    (hViso : ∀ x : Fin', ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : Fin', ∃ y : Fin', A.resCLM l (V x) = V y)
    (hinvq : ∀ x : Fin', ∃ y : Fin', qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ Fin')
    (hcx1 : ‖A.stoneU t - (Polynomial.aeval (A.resCLM l) p).comp qXinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - (Polynomial.aeval (compress V (A.resCLM l)) p).comp qBinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v) :
    ‖A.stoneU t v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by sorry
