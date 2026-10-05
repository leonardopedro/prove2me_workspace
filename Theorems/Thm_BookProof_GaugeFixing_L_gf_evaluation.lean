-- Generated from ChapterGaugeFixing.lean — theorem BookProof.GaugeFixing.L_gf_evaluation
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

theorem BookProof.GaugeFixing.L_gf_evaluation :
    S.s (Psi S) =
      S.sub (2, 0) (S.mul (1, 0) (1, 0) S.B (gaugeField S))
        (S.mul (1, -1) (1, 1) S.c_bar S.c) := by sorry
