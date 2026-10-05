-- Generated from ChapterFiniteSectionSingleTime.lean — theorem BookProof.FiniteSectionSingleTime.finiteSection_singleTime
import Definitions.Def_ChapterStoneTheorem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open `BookProof.HashimotoShiftInvert`.
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.StoneBridge
open BookProof.FiniteSectionSingleTime

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section


theorem BookProof.FiniteSectionSingleTime.finiteSection_singleTime (hsym : SymmetricOn (lpFiniteModes ι) H)
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes ι) H)
    {W : ℕ → Finset ι} (hW : Exhausts W) :
    ∃ (T : UnboundedSelfAdjoint (L2I ι)) (S : ℕ → UnboundedSelfAdjoint (L2I ι)),
      IsSelfAdjointExtension H T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp H (W n) : L2I ι →ₗ[ℂ] L2I ι)).comp (lpFiniteModes ι).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : L2I ι), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : L2I ι), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → L2I ι, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : L2I ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : L2I ι) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
