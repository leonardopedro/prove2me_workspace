-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.wallHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_symmetric
import Theorems.Thm_BookProof_ScalaronWallEsa_kinCcR_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterWeakSecondDerivative
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    SymmetricOn (ccDomain ℝ) (wallHam V hV) :=
  llHam_symmetricOn (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
      SymmetricOn (ccDomain ℝ) (wallHam V hV) := by
    intro x y
    have h1 := kinCcR_symmetricOn x y
    have h2 :=
